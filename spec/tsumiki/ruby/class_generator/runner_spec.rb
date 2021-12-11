# frozen_string_literal: true

describe Tsumiki::Ruby::ClassGenerator::Runner do
  describe 'new instance' do
    subject { Tsumiki::Ruby::ClassGenerator::Runner.new }
    it { is_expected.to be_a Tsumiki::Ruby::ClassGenerator::Runner }
  end

  context 'generate a simple class' do
    let(:class_context) do
      Tsumiki::Ruby::ClassGenerator::Context.new(
        class_name: 'Tsumiki',
        public_methods: [
          { name: 'method', content: '1 + 2' }
        ]
      )
    end

    let(:expected) do
      <<~CLASS
      class Tsumiki
        def method
          1 + 2
        end
      end
      CLASS
    end

    subject { Tsumiki::Ruby::ClassGenerator::Runner.call(class_context) }

    it 'works' do
      is_expected.to eq expected
    end
  end

  context 'generate a class under module' do
    let(:class_context) do
      Tsumiki::Ruby::ClassGenerator::Context.new(
        module: 'GrandParent::Parent',
        class_name: 'Tsumiki',
        public_methods: [
          { name: 'method', content: '1 + 2' }
        ]
      )
    end

    let(:expected) do
      <<~CLASS
      module GrandParent
        module Parent
          class Tsumiki
            def method
              1 + 2
            end
          end
        end
      end
      CLASS
    end

    subject { Tsumiki::Ruby::ClassGenerator::Runner.call(class_context) }

    it 'works' do
      is_expected.to eq expected
    end
  end

  context 'generate a class, withic has private methods' do
    let(:class_context) do
      Tsumiki::Ruby::ClassGenerator::Context.new(
        module: 'GrandParent::Parent',
        class_name: 'Tsumiki',
        public_methods: [
          { name: 'it_is_public_method', content: "'public'" }
        ],
        private_methods: [
          { name: 'it_is_private_method', content: "'private'" }
        ]
      )
    end

    let(:expected) do
      <<~CLASS
      module GrandParent
        module Parent
          class Tsumiki
            def it_is_public_method
              'public'
            end

            private

            def it_is_private_method
              'private'
            end
          end
        end
      end
      CLASS
    end

    subject { Tsumiki::Ruby::ClassGenerator::Runner.call(class_context) }

    it 'works' do
      is_expected.to eq expected
    end
  end

  context 'generate a class, which extends another class' do
    let(:class_context) do
      Tsumiki::Ruby::ClassGenerator::Context.new(
        module: 'GrandParent::Parent',
        class_name: 'Tsumiki',
        parent_class_name: 'ParentClass',
        public_methods: [
          { name: 'method', content: "1 + 2" }
        ]
      )
    end

    let(:expected) do
      <<~CLASS
      module GrandParent
        module Parent
          class Tsumiki < ParentClass
            def method
              1 + 2
            end
          end
        end
      end
      CLASS
    end

    subject { Tsumiki::Ruby::ClassGenerator::Runner.call(class_context) }

    it 'works' do
      is_expected.to eq expected
    end
  end

  context 'generate a class, which has magic comments' do
    let(:class_context) do
      Tsumiki::Ruby::ClassGenerator::Context.new(
        module: 'GrandParent::Parent',
        class_name: 'Tsumiki',
        parent_class_name: 'ParentClass',
        public_methods: [
          { name: 'method', content: "1 + 2" }
        ],
        magic_comments: [
          { key: 'frozen_string_literal', value: true },
          '-*- encoding: UTF-8 -*-'
        ]
      )
    end

    let(:expected) do
      <<~CLASS
      # frozen_string_literal: true
      # -*- encoding: UTF-8 -*-

      module GrandParent
        module Parent
          class Tsumiki < ParentClass
            def method
              1 + 2
            end
          end
        end
      end
      CLASS
    end

    subject { Tsumiki::Ruby::ClassGenerator::Runner.call(class_context) }

    it 'works' do
      is_expected.to eq expected
    end
  end
end
