# frozen_string_literal: true

# == Schema Information
#
# Table name: surveys
#
#  id         :integer          not null, primary key
#  question   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Survey, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:question) }
  end
end
