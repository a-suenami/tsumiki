# frozen_string_literal: true

describe Tsumiki::Ruby::ClassGenerator::Context do
  let(:subject_context) do
    Tsumiki::Ruby::ClassGenerator::Context.new(
      module: 'GrandParent::Parent',
      class_name: 'Tsumiki',
      public_methods: [
        { name: 'method', content: '1 + 2' }
      ]
    )
  end

  it { expect(subject_context).to be_a Tsumiki::Ruby::ClassGenerator::Context }

  describe '#[] (property accessor)' do
    let(:property) do
      [
        :module,
        :class_name,
        :public_methods,
      ].sample
    end

    context 'propery name is a string' do
      subject { subject_context[property.to_s] }
      it 'works' do
        is_expected.not_to eq nil
      end
    end

    context 'propery name is a symbol' do
      subject { subject_context[property.to_sym] }
      it 'works' do
        is_expected.not_to eq nil
      end
    end
  end

  describe 'module' do
    subject { subject_context[:module] }
    it { is_expected.to eq 'GrandParent::Parent' }
  end

  describe 'class_name' do
    subject { subject_context[:class_name] }
    it { is_expected.to eq 'Tsumiki' }
  end

  describe 'public_methods' do
    subject { subject_context[:public_methods] }
    it { is_expected.to be_a Array }
    it 'has specified name and content' do
      is_expected.to eq [{name: 'method', content: '1 + 2'}]
    end
  end
end
