# frozen_string_literal: true

module Tsumiki
  module Ruby
    module ClassGenerator
      class Template
        attr_accessor :context

        def build(context)
          self.context = context
          render_template(root_template)
        end

        def modules
          @modules ||= (context[:module] || '').split('::')
        end

        private

        def indent_level
          @indent_level ||= 0
        end

        def indent!
          @indent_level ||= 0
          @indent_level += 1
        end

        def outdent!
          @indent_level -= 1
        end

        def with_indent
          indent = ' ' * (indent_level * 2)
          indent!
          indent
        end

        def with_outdent
          outdent!
          ' ' * (indent_level * 2)
        end

        def root_template
          <<~TEMPLATE
          <%- modules.each do |m| -%>
          <%= with_indent %>module <%= m %>
          <%- end -%>
          <%= render_class %>
          <%- modules.each do |_| -%>
          <%= with_outdent %>end
          <%- end -%>
          TEMPLATE
        end

        def render_class
          render_template(template_class)
        end

        def template_class
          template = <<~TEMPLATE
          class <%= context[:class_name] %><% if context[:parent_class_name] %> < <%= context[:parent_class_name] %><% end %>
            <%- context[:public_methods].each do |method| -%>
            def <%= method[:name] %>
              <%= method[:content] %>
            end
            <%- end -%>
            <%- unless (context[:private_methods] || []).empty? -%>

            private

            <%- context[:private_methods].each do |method| -%>
            def <%= method[:name] %>
              <%= method[:content] %>
            end
            <%- end -%>
            <%- end -%>
          end
          TEMPLATE

          template.split("\n").map do |line|
            if line.empty?
              line
            else
              (" " * (indent_level * 2)) + line
            end
          end.join("\n")
        end

        def render_template(template)
          ERB.new(template, nil, '-').result(binding)
        end
      end
    end
  end
end
