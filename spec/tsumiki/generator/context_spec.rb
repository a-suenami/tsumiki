# frozen_string_literal: true

describe Tsumiki::Generator::Context do
  describe 'new instance' do
    subject { Tsumiki::Generator::Context.new }
    it { is_expected.to be_a Tsumiki::Generator::Context }
  end
end
