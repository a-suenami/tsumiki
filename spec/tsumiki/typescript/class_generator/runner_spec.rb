# frozen_string_literal: true

describe Tsumiki::Typescript::ClassGenerator::Runner do
  describe 'new instance' do
    subject { Tsumiki::Typescript::ClassGenerator::Runner.new }
    it { is_expected.to be_a Tsumiki::Typescript::ClassGenerator::Runner }
  end

  context 'generate a simple class' do
    let(:class_context) do
      Tsumiki::Typescript::ClassGenerator::Context.new(
        class_name: 'Tsumiki',
        public_methods: [
          { name: 'method', return_type: 'number', content: 'return 1 + 2;' }
        ]
      )
    end

    let(:expected) do
      <<~CLASS
      class Tsumiki {
        method(): number {
          return 1 + 2;
        }
      }
      CLASS
    end

    subject { Tsumiki::Typescript::ClassGenerator::Runner.call(class_context) }

    it 'works' do
      is_expected.to eq expected
    end
  end
end
