# frozen_string_literal: true

# SurveysController
class SurveysController < ApplicationController
  def index
    @surveys = Survey.includes(:responses)
                     .page(params[:page])
                     .per(6)
                     .order(created_at: :desc)
  end

  def create
    @survey = Survey.new(survey_params)
    @surveys = Survey.all
    if @survey.save
      @surveys = Survey.all
      redirect_to surveys_path, notice: 'Survey was successfully created.'
    else
      message = 'Survey was not created.<br>'
      message += @survey.errors.full_messages.join('<br>') if @survey.errors.any?
      redirect_to surveys_path, alert: message.html_safe
    end
  end

  private

  def survey_params
    params.require(:survey).permit(:question)
  end
end
