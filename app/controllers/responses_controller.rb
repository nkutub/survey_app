# frozen_string_literal: true

# ResponsesController
class ResponsesController < ApplicationController
  # Create a new response for a survey
  def create
    @survey = Survey.find(params[:survey_id])
    @response = @survey.responses.build(response_params)

    if @response.save
      redirect_to_survey_path_notice('Response recorded!')
    else
      redirect_to_survey_path_alert('Unable to record response.')
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to surveys_path, alert: 'Survey not found'
  end

  private

  def redirect_to_survey_path_notice(notice)
    redirect_to surveys_path(
      page: params[:page],
      expanded_card: params[:expanded_card],
      responses_page: params[:responses_page],
      anchor: "survey_#{@survey.id}_responses"
    ), notice: notice
  end

  def redirect_to_survey_path_alert(alert)
    redirect_to surveys_path(
      page: params[:page],
      expanded_card: params[:expanded_card],
      responses_page: params[:responses_page],
      anchor: "survey_#{@survey.id}_responses"
    ), alert: alert
  end

  def response_params
    params.require(:response).permit(:answer)
  end
end
