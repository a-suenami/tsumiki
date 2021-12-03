# frozen_string_literal: true

describe Tsumiki::Generator::Template do
  describe 'new instance' do
    subject { Tsumiki::Generator::Template.new }
    it { is_expected.to be_a Tsumiki::Generator::Template }
  end
end
