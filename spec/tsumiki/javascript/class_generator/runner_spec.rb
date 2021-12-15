# frozen_string_literal: true

describe Tsumiki::Javascript::ClassGenerator::Runner do
  describe 'new instance' do
    subject { Tsumiki::Javascript::ClassGenerator::Runner.new }
    it { is_expected.to be_a Tsumiki::Javascript::ClassGenerator::Runner }
  end

  context 'generate a simple class' do
    let(:class_context) do
      Tsumiki::Javascript::ClassGenerator::Context.new(
        class_name: 'Tsumiki',
        public_methods: [
          { name: 'method1', content: 'return 1 + 2;' },
          { name: 'method2', arguments: ['arg1', 'arg2'], content: 'return arg1 + arg2;' }
        ]
      )
    end

    let(:expected) do
      <<~CLASS
      class Tsumiki {
        method1() {
          return 1 + 2;
        }

        method2(arg1, arg2) {
          return arg1 + arg2;
        }

      }
      CLASS
    end

    subject { Tsumiki::Javascript::ClassGenerator::Runner.call(class_context) }

    it 'works' do
      is_expected.to eq expected
    end
  end
end
