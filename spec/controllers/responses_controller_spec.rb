# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe ResponsesController, type: :controller do
  describe 'POST #create' do
    let(:survey) { create(:survey) }

    context 'with valid params' do
      let(:valid_params) do
        {
          survey_id: survey.id,
          response: { answer: 'yes' },
          page: '1',
          expanded_card: survey.id,
          responses_page: '1'
        }
      end

      it 'creates a new response' do
        expect do
          post :create, params: valid_params
        end.to change(Response, :count).by(1)
      end

      it 'associates the response with the correct survey' do
        post :create, params: valid_params
        expect(Response.last.survey).to eq(survey)
      end

      it 'sets the correct answer' do
        post :create, params: valid_params
        expect(Response.last.answer).to eq('yes')
      end

      it 'redirects to surveys path with correct parameters' do
        post :create, params: valid_params
        expect(response).to redirect_to(
          surveys_path(
            page: '1',
            expanded_card: survey.id,
            responses_page: '1',
            anchor: "survey_#{survey.id}_responses"
          )
        )
      end

      it 'sets a success notice' do
        post :create, params: valid_params
        expect(flash[:notice]).to eq('Response recorded!')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        {
          survey_id: survey.id,
          response: { answer: nil },
          page: '1',
          expanded_card: survey.id,
          responses_page: '1'
        }
      end

      it 'does not create a new response' do
        expect do
          post :create, params: invalid_params
        end.not_to change(Response, :count)
      end

      it 'redirects to surveys path with correct parameters' do
        post :create, params: invalid_params
        expect(response).to redirect_to(
          surveys_path(
            page: '1',
            expanded_card: survey.id,
            responses_page: '1',
            anchor: "survey_#{survey.id}_responses"
          )
        )
      end

      it 'sets an error alert' do
        post :create, params: invalid_params
        expect(flash[:alert]).to eq('Unable to record response.')
      end
    end

    context 'with non-existent survey' do
      let(:invalid_survey_params) do
        {
          survey_id: 999_999,
          response: { answer: 'yes' },
          page: '1',
          expanded_card: 999_999,
          responses_page: '1'
        }
      end

      it 'does not create a new response' do
        expect do
          post :create, params: invalid_survey_params
        end.not_to change(Response, :count)
      end

      it 'redirects to surveys path with alert' do
        post :create, params: invalid_survey_params
        expect(response).to redirect_to(surveys_path)
        expect(flash[:alert]).to eq('Survey not found')
      end
    end

    context 'preserves pagination state' do
      let(:pagination_params) do
        {
          survey_id: survey.id,
          response: { answer: 'yes' },
          page: '2',
          expanded_card: survey.id,
          responses_page: '3'
        }
      end

      it 'maintains all pagination parameters after redirect' do
        post :create, params: pagination_params
        expect(response).to redirect_to(
          surveys_path(
            page: '2',
            expanded_card: survey.id,
            responses_page: '3',
            anchor: "survey_#{survey.id}_responses"
          )
        )
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
