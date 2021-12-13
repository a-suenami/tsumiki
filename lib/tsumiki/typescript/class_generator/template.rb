# frozen_string_literal: true

module Tsumiki
  module Typescript
    module ClassGenerator
      class Template
        attr_accessor :context

        def build(context)
          self.context = context
          render_template(root_template)
        end

        def root_template
          <<~TEMPLATE
          class <%= context[:class_name] %> {
            <%- context[:public_methods].each do |method| -%>
            <%= method[:name] %>(): <%= method[:return_type] %> {
              <%= method[:content] %>
            }
            <%- end -%>
          }
          TEMPLATE
        end

        def render_template(template)
          ERB.new(template, nil, '-').result(binding)
        end
      end
    end
  end
end
