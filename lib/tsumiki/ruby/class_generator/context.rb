# frozen_string_literal: true

module Tsumiki
  module Ruby
    module ClassGenerator
      class Context
        def initialize(properties = {})
          @properties = properties
        end

        def [](key)
          @properties[key.to_sym]
        end
      end
    end
  end
end
