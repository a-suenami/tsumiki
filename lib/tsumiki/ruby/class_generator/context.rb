# frozen_string_literal: true

module Tsumiki
  module Ruby
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

        private

        def accessor_include_modules
          value = @properties[:include_modules]
          if value.nil?
            []
          elsif value.is_a?(Array)
            value
          else
            [value]
          end
        end

        def accessor_extend_modules
          value = @properties[:extend_modules]
          if value.nil?
            []
          elsif value.is_a?(Array)
            value
          else
            [value]
          end
        end
      end
    end
  end
end
