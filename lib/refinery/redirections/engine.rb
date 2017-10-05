module Refinery
  module Redirections
    class Engine < Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery::Redirections

      initializer 'register refinerycms_redirections plugin' do
        Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = 'refinerycms_redirections'
          plugin.url = proc {
            Refinery::Core::Engine.routes.url_helpers
                                  .redirections_admin_redirections_path
          }
          plugin.menu_match = %r{refinery\/redirections\/?}
        end
      end

      config.after_initialize do
        Refinery.register_engine(Refinery::Redirections)
      end

      initializer 'add rack rewrite rules' do |app|
        if Refinery::Redirections.enable_rack_redirection
          app.config.middleware.insert_before(Rack::Lock, Rack::Rewrite) do
            Refinery::Redirections::Redirection.all.each do |redirection|
              next unless respond_to? "r#{redirection.status_code}"
              send("r#{redirection.status_code}", redirection.from_url,
                   redirection.to_url)
            end
          end
        end
      end

      paths['config/locales'] << 'config/locales/**'
    end
  end
end
