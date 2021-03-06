class UpdateAspaceActor < Hyrax::Actors::AbstractActor
  def update(env)
    do_ark = env.attributes.fetch(:digital_object_ark) { nil }
    title = env.attributes.fetch(:title) { nil }
    aspace_url = env.attributes.fetch(:aspaceurl) { nil }
    aspace_uri = aspace_url.nil? ? nil : aspace_url.gsub(/https?:\/\/[^\/]+/, '')
    aspace_uuid = env.attributes.fetch(:douuid) { nil }
    visibility = env.attributes.fetch(:visibility) { nil }

    UpdateAspaceJob.perform_later(
      do_ark, 
      aspace_uri, 
      aspace_uuid, 
      title.first || ''
    ) if should_update?(do_ark, aspace_uri, aspace_uuid, visibility) && !title.nil?

    next_actor.update(env)
  end

  def should_update?(do_ark, aspace_uri, aspace_uuid, visibility)
    return !do_ark.blank? && !aspace_uri.blank? && !aspace_uuid.blank? && !private?(visibility)
  end

  def private?(visibility)
    return visibility == Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PRIVATE
  end

end