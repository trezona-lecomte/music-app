require 'rails_helper'

RSpec.describe Album, :type => :model do
  describe "validations" do
    subject { Album.new(attributes) }

    context "when the name is blank" do
      let(:attributes) { { name: "" } }

      it { is_expected.to be_invalid }
    end
  end
end
