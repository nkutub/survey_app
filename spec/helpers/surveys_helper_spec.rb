# frozen_string_literal: true

require 'rails_helper'
# rubocop:disable Metrics/BlockLength
RSpec.describe SurveysHelper, type: :helper do
  describe 'survey_formated_yes_percentage' do
    it 'should return the percentage of yes responses' do
      survey = create(:survey, :survey_with_50_percent_yes)
      expect(helper.survey_formated_yes_percentage(survey)).to eq('50.0%')
    end
  end

  describe 'survey_formated_no_percentage' do
    it 'should return the percentage of no responses' do
      survey = create(:survey, :survey_with_50_percent_no)
      expect(helper.survey_formated_no_percentage(survey)).to eq('50.0%')
    end
  end

  describe 'survey_formated_created_at' do
    it 'should return the formatted created at date' do
      survey = create(:survey, created_at: Time.zone.local(2021, 1, 1, 1, 0, 0))
      expect(helper.survey_formated_created_at(survey)).to eq('January 01, 2021 at 01:00 AM')
    end
  end

  describe 'survey_formated_response_created_at' do
    it 'should return the formatted created at date' do
      response = create(:response, created_at: Time.zone.local(2021, 1, 1, 1, 0, 0))
      expect(helper.survey_formated_response_created_at(response)).to eq('January 01, 2021 at 01:00 AM')
    end
  end

  describe 'survey_current_page_responses' do
    it 'should return the current page responses' do
      survey = create(:survey)
      create_list(:response, 15, survey: survey)
      expect(helper.survey_current_page_responses(survey)).to respond_to(:current_page)
      expect(helper.survey_current_page_responses(survey)).to respond_to(:total_pages)
      expect(helper.survey_current_page_responses(survey).size).to eq(10)
    end
  end
end
# rubocop:enable Metrics/BlockLength
