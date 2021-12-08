# frozen_string_literal: true

module Tsumiki
  module Ruby
    module ClassGenerator
      class Context
        def initialize(properties = {})
          @properties = properties
        end

        def [](key)
          value = @properties[key.to_sym]
          if value.is_a?(Hash)
            Context.new(value)
          else
            value
          end
        end
      end
    end
  end
end
