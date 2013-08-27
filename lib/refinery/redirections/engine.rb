module Refinery
  module Redirections
    class Engine < Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery::Redirections

      initializer "register refinerycms_redirections plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = "refinerycms_redirections"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.redirections_admin_redirections_path }
          plugin.menu_match = /refinery\/redirections\/?/
          plugin.activity = { :class_name => :'refinery/redirections/redirection' }
        end
      end

      config.after_initialize do
        Refinery.register_engine(Refinery::Redirections)
      end
    end
  end
end
