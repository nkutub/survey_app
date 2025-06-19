# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'surveys/index', type: :view do
  context 'when there are no surveys' do
    before do
      assign(:surveys, Survey.page(1))
      render
    end

    it 'displays no surveys message' do
      expect(rendered).to have_selector('.alert.alert-info', text: 'No surveys found')
    end
  end

  context 'when there are surveys' do
    let(:surveys) { create_list(:survey, 7) } # Create 7 surveys to force pagination

    before do
      # Create a paginated relation instead of an array
      @paginated_surveys = Survey.page(1).per(6)

      # Stub the pagination methods
      allow(@paginated_surveys).to receive(:total_pages).and_return(2)
      allow(@paginated_surveys).to receive(:current_page).and_return(1)
      allow(@paginated_surveys).to receive(:limit_value).and_return(6)
      allow(@paginated_surveys).to receive(:total_count).and_return(7)
      allow(@paginated_surveys).to receive(:any?).and_return(true)
      allow(@paginated_surveys).to receive(:each).and_yield(surveys.first)

      assign(:surveys, @paginated_surveys)

      # Add responses to first survey
      survey = surveys.first
      create(:response, survey: survey, answer: :yes)
      create(:response, survey: survey, answer: :no)

      render
    end

    it 'renders survey cards' do
      expect(rendered).to have_content(surveys.first.question)
      expect(rendered).to have_selector('.survey-card')
    end

    it 'shows survey statistics' do
      expect(rendered).to have_content('Responses')
      expect(rendered).to have_content('Yes %')
      expect(rendered).to have_selector("button[data-bs-toggle='collapse']", text: 'View Responses')
    end

    it 'shows responses in the collapsible section' do
      survey = surveys.first
      expect(rendered).to have_selector("#responses-#{survey.id}")
      expect(rendered).to have_content('Recent Responses')
      expect(rendered).to have_selector('.badge', text: 'YES')
      expect(rendered).to have_selector('.badge', text: 'NO')
    end

    it 'shows pagination' do
      expect(@paginated_surveys.total_pages).to eq(2)
      expect(rendered).to have_selector('nav')
      expect(rendered).to have_selector('.page-item')
      expect(rendered).to have_selector('.page-link')
    end
  end
end
# rubocop:enable Metrics/BlockLength
