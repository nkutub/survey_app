require 'rails_helper'

RSpec.describe Survey, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:question) }
  end
end
