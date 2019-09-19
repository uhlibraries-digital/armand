module HyraxHelper
  include ::BlacklightHelper
  include Hyrax::BlacklightOverride
  include Hyrax::HyraxHelperBehavior
  include DownloadHelper

  def collection_title_by_id(id)
    begin
      solr_docs = controller.repository.find(id).docs
      return nil if solr_docs.empty?
    rescue Blacklight::Exceptions::RecordNotFound
      return nil
    end
    solr_field = solr_docs.first[ActiveFedora.index_field_mapper.solr_name("title", :stored_searchable)]
    return nil if solr_field.nil?
    solr_field.first
  end
end
