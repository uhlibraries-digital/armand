module GreensClient
  class ArkProxy < Flexirest::ProxyBase
    get "/id/:id" do
      response = passthrough
      translate(response) do |body|
        body = body["ark"]
        body
      end
    end
  end
end