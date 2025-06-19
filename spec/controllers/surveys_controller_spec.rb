# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe SurveysController, type: :controller do
  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) { { question: 'Is this a valid question?' } }

      it 'creates a new Survey' do
        expect do
          post :create, params: { survey: valid_attributes }
        end.to change(Survey, :count).by(1)
      end

      it 'redirects to the surveys list' do
        post :create, params: { survey: valid_attributes }
        expect(response).to redirect_to(surveys_path)
      end

      it 'sets a success flash message' do
        post :create, params: { survey: valid_attributes }
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { { question: '' } }

      it 'does not create a new Survey' do
        expect do
          post :create, params: { survey: invalid_attributes }
        end.not_to change(Survey, :count)
      end

      it 'returns unprocessable_entity status' do
        post :create, params: { survey: invalid_attributes }
        expect(response).to have_http_status(:redirect)
      end

      it 'renders the form again' do
        post :create, params: { survey: invalid_attributes }
        expect(response).to redirect_to(surveys_path)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
