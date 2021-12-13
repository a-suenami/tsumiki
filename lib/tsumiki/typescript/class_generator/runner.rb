# frozen_string_literal: true

module Tsumiki
  module Typescript
    module ClassGenerator
      class Runner
        def self.call(context)
          template = Template.new
          template.build(context)
        end
      end
    end
  end
end
