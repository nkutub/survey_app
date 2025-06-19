# frozen_string_literal: true

# Surveys
require 'rails_helper'

RSpec.describe 'Surveys', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/surveys/index'
      expect(response).to have_http_status(:success)
    end
  end
end
