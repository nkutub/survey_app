# frozen_string_literal: true

# Surveys
require 'rails_helper'

RSpec.describe 'Surveys', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/surveys' # The test is probably using this path
      expect(response).to have_http_status(:success)
    end
  end
end
