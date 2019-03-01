class IIIFAuthorizationService
  attr_reader :controller
  def initialize(controller)
    @controller = controller
  end

  # @note we ignore the `action` param here in favor of the `:show` action for all permissions
  def can?(_action, object)
    Rails.logger.info("IIIFAuthorizationService can?")
    controller.current_ability.can?(:show, file_set_id_for(object))
  end

  private

    def file_set_id_for(object)
      Rails.logger.info("FILE SET ID FOR #{object.inspect}")
      if object.id.include? '/'
        object.id.split('/').first
      else
        URI.decode(object.id).split('/').first
      end
    end
end