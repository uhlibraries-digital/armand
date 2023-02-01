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
  before_action :discard_flash_if_authenticated, only: [:show]
  before_action :site_alert

  def current_ability
    session_opts ||= user_session
    session_opts ||= {}
    @current_ability ||= Ability.new(current_user, session_opts.merge(remote_ip: request.remote_ip))
  end

  def site_alert
    @site_alert = Armand::AlertManager.find(Settings.alertmanager.id).html_safe rescue ''
  end

  def discard_flash_if_authenticated
    if Settings.saml.active && flash[:alert] == "You are not authorized to access this page."
      flash.delete(:alert)
    end
  end

  private

    def require_active_account!
    end

end
