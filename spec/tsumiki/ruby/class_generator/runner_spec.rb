# frozen_string_literal: true

describe Tsumiki::Ruby::ClassGenerator::Runner do
  describe 'new instance' do
    subject { Tsumiki::Ruby::ClassGenerator::Runner.new }
    it { is_expected.to be_a Tsumiki::Ruby::ClassGenerator::Runner }
  end

  context 'generate a simple class' do
    it do
      class_context = {
        class_name: 'Tsumiki',
        public_methods: [
          { name: 'method', content: '1 + 2' }
        ]
      }
      generated_class_string = Tsumiki::Ruby::ClassGenerator::Runner.call(class_context)

      expected = <<~CLASS
      class Tsumiki
        def method
          1 + 2
        end
      end
      CLASS

      expect(generated_class_string).to eq expected
    end

    it do
      class_context = {
        class_name: 'Tsumiki2',
        public_methods: [
          { name: 'new_method', content: 'a + b' }
        ]
      }
      generated_class_string = Tsumiki::Ruby::ClassGenerator::Runner.call(class_context)

      expected = <<~CLASS
      class Tsumiki2
        def new_method
          a + b
        end
      end
      CLASS

      expect(generated_class_string).to eq expected
    end
  end
end
