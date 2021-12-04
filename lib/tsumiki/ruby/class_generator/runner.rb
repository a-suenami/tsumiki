# frozen_string_literal: true

module Tsumiki
  module Ruby
    module ClassGenerator
      class Runner
        def self.call(context)
          ERB.new(template, nil, '-').result(binding)
        end

        private

        def self.template
          <<~CLASS
          class <%= context[:class_name] %>
            <%- context[:public_methods].each do |method| -%>
            def <%= method[:name] %>
              <%= method[:content] %>
            end
            <%- end -%>
          end
          CLASS
        end
      end
    end
  end
end
