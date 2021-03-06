module Aspace
  class DigitalObject < Flexirest::Base

    perform_caching false
    request_body_type :json

    before_request :add_authentication_details
    before_request :replace_body

    base_url Settings.aspace.endpoint
    get :find, ":id"
    post :save, ":id"
    post :create, "/repositories/:repo_id/digital_objects"

    def add_authentication_details(name, request)
      request.headers["X-ArchivesSpace-Session"] = Aspace::Session.session
    end

    def replace_body(name, request)
      if name == :create
        request.body = request.post_params[:digital_object].to_json
      end
      if name == :save
        request.body = request.post_params.to_json
      end
    end

  end
end