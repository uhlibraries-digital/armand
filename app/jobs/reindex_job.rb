class ReindexJob < ActiveJob::Base 
  def perform
    descendants = ActiveFedora::Base.descendant_uris(ActiveFedora.fedora.base_uri)
    descendants.shift # remove the root
    descendants.each do |uri|
      begin
        ActiveFedora::Base.find(ActiveFedora::Base.uri_to_id(uri)).update_index
        Rails.logger.info "#{uri} reindexed"
      rescue
        Rails.logger.error "Error reindexing #{uri}"
      end
    end
  end
end