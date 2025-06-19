# frozen_string_literal: true

# Responses
require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'surveys/_responses', type: :view do
  let(:survey) { create(:survey, question: 'Test question?') }
  let(:responses) { survey.responses.page(1).per(10) }

  before do
    allow(view).to receive(:params).and_return({
                                                 page: '1',
                                                 expanded_card: survey.id,
                                                 responses_page: '1'
                                               })
  end

  context 'when rendering the form' do
    before do
      render partial: 'surveys/responses', locals: { survey: survey, responses: responses }
    end

    it 'renders the response form' do
      expect(rendered).to have_selector("form[action='#{survey_responses_path(survey)}']")
      expect(rendered).to have_select('response[answer]', options: %w[No Yes])
      expect(rendered).to have_button('Submit Response')
    end

    it "has 'No' selected by default" do
      expect(rendered).to have_select('response[answer]', selected: 'No')
    end

    it 'includes necessary hidden fields' do
      expect(rendered).to have_field('page', type: 'hidden', with: '1')
      expect(rendered).to have_field('expanded_card', type: 'hidden', with: survey.id)
      expect(rendered).to have_field('responses_page', type: 'hidden', with: '1')
    end
  end

  context 'when there are no responses' do
    before do
      render partial: 'surveys/responses', locals: { survey: survey, responses: responses }
    end

    it 'shows empty responses section' do
      expect(rendered).to have_content('Recent Responses')
      expect(rendered).not_to have_selector('.badge')
    end

    it 'does not show pagination' do
      expect(rendered).not_to have_selector('.pagination')
    end
  end

  context 'when there are responses' do
    before do
      create(:response, survey: survey, answer: :yes)
      create(:response, survey: survey, answer: :no)
      render partial: 'surveys/responses', locals: { survey: survey, responses: survey.responses.page(1) }
    end

    it 'displays responses with correct styling' do
      expect(rendered).to have_selector('.badge.bg-success', text: 'YES')
      expect(rendered).to have_selector('.badge.bg-danger', text: 'NO')
    end

    it 'shows response timestamps' do
      survey.responses.each do |response|
        expect(rendered).to have_content(response.created_at.strftime('%B %d, %Y at %I:%M %p'))
      end
    end

    it 'orders responses by most recent first' do
      response_elements = Nokogiri::HTML(rendered).css('.badge')
      expect(response_elements.first.text.strip).to eq('NO')
      expect(response_elements.last.text.strip).to eq('YES')
    end
  end

  context 'with pagination' do
    before do
      create_list(:response, 15, survey: survey, answer: :yes)
      @responses = survey.responses.order(created_at: :desc).page(1).per(10)
      allow(@responses).to receive(:total_pages).and_return(2)
      allow(@responses).to receive(:current_page).and_return(1)

      render partial: 'surveys/responses', locals: {
        survey: survey,
        responses: @responses
      }
    end

    it 'shows pagination buttons when there are more than 10 responses' do
      expect(rendered).to have_selector('.btn-sm', text: '1')
      expect(rendered).to have_selector('.btn-sm', text: '2')
    end

    it 'highlights current page button' do
      expect(rendered).to have_selector('.btn-primary', text: '1')
      expect(rendered).to have_selector('.btn-outline-primary', text: '2')
    end

    it 'limits responses to 10 per page' do
      expect(rendered).to have_selector('.badge', count: 10)
    end

    it 'maintains state in pagination links' do
      expect(rendered).to have_link('2', href: /responses_page=2/)
      expect(rendered).to have_link('2', href: /expanded_card=#{survey.id}/)
      expect(rendered).to have_link('2', href: /page=#{params[:page]}/)
    end
  end
end
# rubocop:enable Metrics/BlockLength
