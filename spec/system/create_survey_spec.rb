require 'rails_helper'

RSpec.describe 'Creating a survey', type: :system do
  before do
    driven_by(:rack_test)
  end

  scenario 'valid question' do
    visit surveys_path
    fill_in 'survey[question]', with: 'Is this a good question?'
    click_button 'Create Survey'

    expect(page).to have_text('Survey was successfully created')
    expect(page).to have_text('Is this a good question?')
  end

  scenario 'invalid question' do
    visit surveys_path
    fill_in 'survey[question]', with: ''
    click_button 'Create Survey'

    expect(page).to have_text('Survey was not created')
  end

  scenario 'form is present on the index page' do
    visit surveys_path
    expect(page).to have_selector('form')
    expect(page).to have_field('survey[question]')
    expect(page).to have_button('Create Survey')
  end
end
