class UpdateArkIdentifierJob < ActiveJob::Base
  queue_as Hyrax.config.ingest_queue_name

  def perform(ark_id, erc_where)
    ark = Greens::Ark.new
    ark.id = ark_id
    ark.where = erc_where
    begin
      ark.save
    rescue Exception => e
      logger.error "Unable to save ark (#{ark_id}) : #{e.message} : #{e}"
      raise e.message
    end
  end
end