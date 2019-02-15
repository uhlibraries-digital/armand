class UpdateArkIdentifierJob < ActiveJob::Base
  queue_as :update_ark_identifier

  def perform(ark_id, erc_where)
    ark = GreensClient::Ark.new
    ark.id = ark_id
    ark.where = erc_where
    ark.save
  end
end