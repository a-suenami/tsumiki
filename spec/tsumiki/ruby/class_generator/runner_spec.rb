# frozen_string_literal: true

describe Tsumiki::Ruby::ClassGenerator::Runner do
  describe 'new instance' do
    subject { Tsumiki::Ruby::ClassGenerator::Runner.new }
    it { is_expected.to be_a Tsumiki::Ruby::ClassGenerator::Runner }
  end

  context 'generate a simple class' do
    let(:class_context) do
      {
        class_name: 'Tsumiki',
        public_methods: [
          { name: 'method', content: '1 + 2' }
        ]
      }
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
      {
        module: 'GrandParent::Parent',
        class_name: 'Tsumiki',
        public_methods: [
          { name: 'method', content: '1 + 2' }
        ]
      }
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
end
