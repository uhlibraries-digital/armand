module Aspace
  class Session < Flexirest::Base
    base_url Settings.aspace.endpoint
    perform_caching false

    def self.session
      if @session.nil? || @session[:expires] <= Time.now.to_i
        data = self._request(
          "#{Settings.aspace.endpoint}/users/#{Settings.aspace.username}/login",
          :post,
          {password: Settings.aspace.password}
        )
        @session = {
          id: data.session,
          expires: Time.now.to_i + 3600
        }
      end
      @session[:id]
    end
  end
end