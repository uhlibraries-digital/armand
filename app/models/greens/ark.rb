module Greens
  class Ark < Flexirest::Base
    proxy Greens::ArkProxy

    before_request :add_authentication_details

    perform_caching false

    base_url Settings.greens.endpoint
    get :find, "/id/:id"
    put :save, "/id/:id"
    post :create, "/arks/mint/#{Settings.greens.prefix.to_s}"

    def add_authentication_details(name, request)
      request.headers["api-key"] = Settings.greens.api_key.to_s
    end

  end
end