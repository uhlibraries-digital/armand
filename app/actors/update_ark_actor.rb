class UpdateArkActor < Hyrax::Actors::AbstractActor
  include Rails.application.routes.url_helpers
  include ActionDispatch::Routing::PolymorphicRoutes

  def create(env)
    ark_id = env.attributes.fetch(:digital_object_ark) { nil }
    if !ark_id.nil? && !ark_id.blank?
      where = polymorphic_url(env.curation_concern, {:host => Settings.armand.host})
      UpdateArkIdentifierJob.perform_later(ark_id, where)
    end
    next_actor.create(env)
  end
end