module Refinery
  class RedirectionsGenerator < Rails::Generators::Base
    def rake_db
      rake 'refinery_redirections:install:migrations'
    end

    def append_load_seed_data
      create_file 'db/seeds.rb' unless File.exist?(
        File.join(destination_root, 'db', 'seeds.rb')
      )
      append_file 'db/seeds.rb', verbose: true do
        <<~EOH

          # Added by Refinery CMS Redirections extension
          Refinery::Redirections::Engine.load_seed
        EOH
      end
    end

    source_root File.expand_path('templates', __dir__)

    def generate_ue_core_initializer
      template(
        "config/initializers/refinery/redirections.rb.erb",
        File.join(
          destination_root, "config", "initializers", "refinery",
          "redirections.rb"
        )
      )
    end
  end
end
