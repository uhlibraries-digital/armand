module Aspace
  class TopContainer < Flexirest::Base

    perform_caching false
    request_body_type :json

    before_request :add_authentication_details

    base_url Settings.aspace.endpoint
    get :find, ":id"

    def add_authentication_details(name, request)
      request.headers["X-ArchivesSpace-Session"] = Aspace::Session.session
    end

  end
end