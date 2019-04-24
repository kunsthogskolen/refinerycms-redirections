module Refinery
  module Redirections
    class Tab
      attr_accessor :name, :partial

      def self.register(&block)
        tab = new

        yield tab

        raise "A tab MUST have a name!: #{tab.inspect}" if tab.name.blank?
        raise "A tab MUST have a partial!: #{tab.inspect}" if tab.partial.blank?
      end

      protected

      def initialize
        # add me to the collection of registered page tabs
        ::Refinery::Redirections.tabs << self
      end
    end
  end
end
