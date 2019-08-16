class UpdateArkIdentifierJob < ActiveJob::Base
  queue_as Hyrax.config.ingest_queue_name

  def perform(ark_id, erc_where)
    ark = Greens::Ark.new
    ark.id = ark_id
    ark.where = erc_where
    ark.save
  end
end