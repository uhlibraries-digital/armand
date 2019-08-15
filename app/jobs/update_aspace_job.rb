class UpdateAspaceJob < ActiveJob::Base
  queue_as Hyrax.config.ingest_queue_name

  def perform(do_ark, aspace_uri, do_uuid, title)
    ark_url = "#{Settings.greens.base_url}#{do_ark}"
    @archival_object = Aspace::ArchivalObject.find(aspace_uri)
    repository_id = /\/repositories\/(\d+)/.match(@archival_object.repository.ref)[1]

    digital_object = get_digital_object do_uuid
    if digital_object.nil?
      Rails.logger.info "Adding Digital Object to #{aspace_uri}"
      digital_object = new_aspace_do do_uuid
      new_file_version = new_aspace_file_version ark_url
      digital_object[:file_versions] << new_file_version
      @digital_object = Aspace::DigitalObject.create(
        repo_id: repository_id,
        digital_object: digital_object)
      new_instance = new_aspace_instance @digital_object.uri
      @archival_object.instances << new_instance
      @archival_object.id = @archival_object.uri
      @archival_object.save
    elsif !has_do_ark(digital_object.file_versions, ark_url)
      @digital_object = Aspace::DigitalObject.find(digital_object.uri)
      new_file_version = new_aspace_file_version ark_url
      @digital_object.file_versions << new_file_version
      @digital_object.id = @digital_object.uri
      @digital_object.save
    else
      Rails.logger.info "Digtal object for #{ark_url} already exists"
      return
    end
  end

  def get_digital_object(uuid)
    @archival_object.instances.each do |instance|
      if instance.instance_type == "digital_object"
        digital_object = Aspace::DigitalObject.find(instance.digital_object.ref)
        if digital_object.digital_object_id == uuid
          return digital_object
        end
      end
    end
    return nil
  end

  def has_do_ark(file_versions, ark_url)
    file_versions.each do |file|
      if file.file_uri == ark_url
        return true
      end
    end
    return false
  end

  def new_aspace_do(uuid, title)
    return {
      "jsonmodel_type": "digital_object",
      "digital_object_id": uuid,
      "external_ids": [],
      "subjects": [],
      "linked_events": [],
      "extends": [],
      "dates": [],
      "external_documents": [],
      "rights_statements": [],
      "linked_agents": [],
      "file_versions": [],
      "restrictions": false,
      "notes": [],
      "linked_instances": [],
      "title": title,
      "language": "",
      "publish": true
    }
  end

  def new_aspace_instance(uri)
    return {
      "jsonmodel_type": "instance",
      "digital_object": {
          "ref": uri
      },
      "instance_type": "digital_object",
      "is_representative": false
    }
  end

  def new_aspace_file_version(ark_url)
    return {
      "jsonmodel_type": "file_version",
      "is_representative": false,
      "file_uri": ark_url,
      "use_statement": "Access",
      "xlink_actuate_attribute": "",
      "xlink_show_attribute": "",
      "file_format_name": "",
      "file_format_version": "",
      "checksum": "",
      "checksum_method": "",
      "publish": true
    }
  end

end