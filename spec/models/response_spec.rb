# frozen_string_literal: true

# == Schema Information
#
# Table name: responses
#
#  id         :integer          not null, primary key
#  survey_id  :integer          not null
#  answer     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Response, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:survey) }
  end

  it 'is not valid without a survey' do
    response = build(:response, survey: nil)
    expect(response).to_not be_valid
  end

  it 'is not valid without an answer' do
    response = build(:response, answer: nil)
    expect(response).to_not be_valid
  end
end
