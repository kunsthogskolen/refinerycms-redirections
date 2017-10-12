module Refinery
  module Redirections
    module Admin
      class RedirectionsController < ::Refinery::AdminController
        crudify :'refinery/redirections/redirection', title_attribute: :from_url

        private

        def redirection_params
          params.require(:redirection).permit(
            :from_url, :to_url, :status_code
          )
        end
      end
    end
  end
end
