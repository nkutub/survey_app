# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
# Creating a response
RSpec.describe 'Creating a response', type: :system do
  let!(:survey) { create(:survey, question: 'Is this a test question?') }

  before do
    driven_by(:rack_test)
    visit surveys_path
  end

  context 'when creating a response' do
    it "allows creating a response with default 'No'" do
      # Click to expand responses section
      click_button 'View Responses'

      within("#responses-#{survey.id}") do
        # Default should be 'No'
        expect(page).to have_select('response[answer]', selected: 'No')
        click_button 'Submit Response'
      end

      # Check if response was created
      within("#responses-#{survey.id}") do
        expect(page).to have_content('NO')
        expect(page).to have_content(Time.current.strftime('%B %d, %Y'))
      end
      expect(page).to have_content('Response recorded!')
    end

    it "allows creating a 'Yes' response" do
      click_button 'View Responses'

      within("#responses-#{survey.id}") do
        select 'Yes', from: 'response[answer]'
        click_button 'Submit Response'
      end

      within("#responses-#{survey.id}") do
        expect(page).to have_content('YES')
        expect(page).to have_content(Time.current.strftime('%B %d, %Y'))
      end
      expect(page).to have_content('Response recorded!')
    end

    it 'allows creating multiple responses' do
      click_button 'View Responses'

      # Create first response
      within("#responses-#{survey.id}") do
        select 'Yes', from: 'response[answer]'
        click_button 'Submit Response'
      end

      # Create second response
      within("#responses-#{survey.id}") do
        select 'No', from: 'response[answer]'
        click_button 'Submit Response'
      end

      # Verify both responses are shown
      within("#responses-#{survey.id}") do
        expect(page).to have_content('YES')
        expect(page).to have_content('NO')
        expect(page).to have_selector('.badge', count: 2)
      end
    end

    context 'with pagination' do
      before do
        # Create 11 responses to trigger pagination
        11.times { create(:response, survey: survey, answer: :yes) }
      end

      it 'shows paginated responses after creating a new one' do
        click_button 'View Responses'

        within("#responses-#{survey.id}") do
          select 'No', from: 'response[answer]'
          click_button 'Submit Response'

          # Should show the new response on first page
          expect(page).to have_content('NO')
          # Should have pagination
          expect(page).to have_link('2')
          # Should show only 10 responses per page
          expect(page).to have_selector('.badge', count: 10)
        end
      end
    end

    context 'when on second page of surveys' do
      before do
        # Create enough surveys to trigger pagination
        create_list(:survey, 6)
        visit surveys_path(page: 2)
      end

      it 'maintains survey page after creating response' do
        click_button 'View Responses'

        within("#responses-#{survey.id}") do
          select 'Yes', from: 'response[answer]'
          click_button 'Submit Response'
        end

        # Should still be on page 2
        expect(current_url).to include('page=2')
        expect(page).to have_content(survey.question)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
