module Refinery
  module Redirections
    module Admin
      class RedirectionsController < ::Refinery::AdminController
        crudify :'refinery/redirections/redirection',
                title_attribute: :from_url,
                order: 'updated_at desc',
                searchable: false, sortable: false

        private

        def redirection_params
          params.require(:redirection).permit(permitted_redirection_params)
        end

        def permitted_redirection_params
          %i[
            from_url to_url status_code
          ]
        end
      end
    end
  end
end
