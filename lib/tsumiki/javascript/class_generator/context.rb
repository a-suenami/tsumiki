# frozen_string_literal: true

module Tsumiki
  module Javascript
    module ClassGenerator
      class Context
        def initialize(properties = {})
          @properties = properties
        end

        def [](key)
          accessor = "accessor_#{key}"
          return send(accessor) if respond_to?(accessor, true)

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
