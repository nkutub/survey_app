# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'surveys/index.html.erb', type: :view do
  describe 'check to that the key elements are visible' do
    context 'no data' do
      before do
        assign(:surveys, [])
      end
      it 'should have a title' do
        render
        expect(rendered).to have_selector('h1', text: 'Surveys')
      end
      it 'should have a message' do
        render
        expect(rendered).to have_selector('td', text: 'No surveys found')
      end
    end
  end
end
