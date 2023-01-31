module Armand
  class AlertManager < Flexirest::Base

    perform_caching false

    base_url Settings.alertmanager.endpoint
    get :find, "/:id", plain: true

  end
end