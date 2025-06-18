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

  describe 'percent_yes' do
    let(:survey) { create(:survey) }

    it 'returns the percentage of yes responses for 100% yes' do
      create(:response, survey: survey, answer: true)
      expect(survey.percent_yes).to eq(100)
    end

    it 'returns the percentage of yes responses for 50% yes' do
      create(:response, survey: survey, answer: true)
      create(:response, survey: survey, answer: false)
      expect(survey.percent_yes).to eq(50)
    end

    it 'returns the percentage of yes responses for fraction of yes' do
      create(:response, survey: survey, answer: true)
      create(:response, survey: survey, answer: true)
      create(:response, survey: survey, answer: false)
      expect(survey.percent_yes).to be_within(0.01).of(66.67)
    end

    it 'returns the percentage of yes responses for 0% yes' do
      create(:response, survey: survey, answer: false)
      expect(survey.percent_yes).to eq(0)
    end
  end
end
