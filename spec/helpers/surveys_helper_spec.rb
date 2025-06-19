# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SurveysHelper, type: :helper do
  describe 'survey_formated_yes_percentage' do
    it 'should return the percentage of yes responses' do
      survey = create(:survey, :survey_with_50_percent_yes)
      expect(helper.survey_formated_yes_percentage(survey)).to eq('50.0%')
    end
  end

  describe 'survey_formated_created_at' do
    it 'should return the formatted created at date' do
      survey = create(:survey, created_at: Time.zone.local(2021, 1, 1, 1, 0, 0))
      expect(helper.survey_formated_created_at(survey)).to eq('January 01, 2021 at 01:00 AM')
    end
  end
end
