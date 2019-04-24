require 'refinerycms-core'
require 'rack/rewrite'
require 'enumerize'

module Refinery
  autoload :RedirectionsGenerator, 'generators/refinery/redirections_generator'

  module Redirections
    require 'refinery/redirections/engine'
    require 'refinery/redirections/configuration'
    require 'refinery/redirections/routes_constraint'

    autoload :Tab, 'refinery/redirections/tab'

    class << self
      attr_writer :root
      attr_writer :tabs

      def root
        @root ||= Pathname.new(File.expand_path('../..', __dir__))
      end

      def tabs
        @tabs ||= []
      end

      def factory_paths
        @factory_paths ||= [root.join('spec', 'factories').to_s]
      end
    end
  end
end
