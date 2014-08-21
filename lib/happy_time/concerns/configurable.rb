module HappyTime
  module Concerns
    module Configurable
      extend ActiveSupport::Concern

      included do
        def configuration
          self.class.configuration
        end
      end

      module ClassMethods
        def configuration
          HappyTime.configuration
        end
      end
    end
  end
end