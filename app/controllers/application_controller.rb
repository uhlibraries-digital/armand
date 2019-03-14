class ApplicationController < ActionController::Base
  helper Openseadragon::OpenseadragonHelper
  # Adds a few additional behaviors into the application controller
  include Blacklight::Controller
  skip_after_action :discard_flash_if_xhr
  include Hydra::Controller::ControllerBehavior

  # Adds Hyrax behaviors into the application controller
  include Hyrax::Controller
  include Hyrax::ThemedLayoutController
  with_themed_layout '1_column'


  protect_from_forgery with: :exception

  before_action :require_active_account!

  def current_ability
    session_opts ||= user_session
    session_opts ||= {}
    @current_ability ||= Ability.new(current_user, session_opts.merge(remote_ip: request.remote_ip))
  end

  private

    def require_active_account!
    end

end
