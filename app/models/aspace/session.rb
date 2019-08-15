module Aspace
  class Session < Flexirest::Base
    base_url Settings.aspace.endpoint
    perform_caching false

    def self.session
      if @session.nil?
        @session = self._request(
          "#{Settings.aspace.endpoint}/users/#{Settings.aspace.username}/login",
          :post,
          {password: Settings.aspace.password}
        )
      end
      @session.session
    end
  end
end