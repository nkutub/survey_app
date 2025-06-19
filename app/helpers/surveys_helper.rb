# frozen_string_literal: true

# SurveysHelper
module SurveysHelper
  def survey_formatted_yes_percentage(survey)
    number_to_percentage(survey.percent_yes, precision: 1)
  end

  def survey_formatted_no_percentage(survey)
    number_to_percentage(survey.percent_no, precision: 1)
  end

  def survey_formatted_created_at(survey)
    survey.created_at.strftime('%B %d, %Y at %I:%M %p')
  end

  def survey_formatted_response_created_at(response)
    response.created_at.strftime('%B %d, %Y at %I:%M %p')
  end

  def survey_current_page_responses(survey)
    survey.responses.page(params[:responses_page]).per(10).order(created_at: :desc)
  end
end
