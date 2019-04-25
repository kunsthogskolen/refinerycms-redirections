module Refinery
  module Redirections
    class RedirectionsController < ::ApplicationController
      def redirect
        redirection =
          Refinery::Redirections::Redirection.from_url(request.fullpath).first
        return if redirection.nil?

        redirect_to(redirection.to_url, status: redirection.status_code)
      end
    end
  end
end
