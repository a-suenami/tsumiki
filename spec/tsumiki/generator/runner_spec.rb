# frozen_string_literal: true

describe Tsumiki::Generator::Runner do
  describe 'new instance' do
    subject { Tsumiki::Generator::Runner.new }
    it { is_expected.to be_a Tsumiki::Generator::Runner }
  end
end
