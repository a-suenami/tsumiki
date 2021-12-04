# frozen_string_literal: true

module Tsumiki
  module Ruby
    module ClassGenerator
      class Runner
        def self.call(context)
          modules = (context[:module] || '').split('::')

          ERB.new(template, nil, '-').result(binding)
        end

        private

        def self.template
          <<~CLASS
          <%- indent_level = 0 -%>
          <%- modules.each do |m| -%>
          <%= ' ' * (indent_level * 2) %>module <%= m %>
          <%- indent_level += 1 -%>
          <%- end -%>
          <%= ' ' * (indent_level * 2) %>class <%= context[:class_name] %>
          <%- context[:public_methods].each do |method| -%>
          <%= ' ' * (indent_level * 2) %>  def <%= method[:name] %>
          <%= ' ' * (indent_level * 2) %>    <%= method[:content] %>
          <%= ' ' * (indent_level * 2) %>  end
          <%- end -%>
          <%= ' ' * (indent_level * 2) %>end
          <%- modules.each do |_| -%>
          <%- indent_level -= 1 -%>
          <%= ' ' * (indent_level * 2) %>end
          <%- end -%>
          CLASS
        end
      end
    end
  end
end
