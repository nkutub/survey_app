# frozen_string_literal: true

# SurveysHelper
module SurveysHelper
  def survey_formated_yes_percentage(survey)
    number_to_percentage(survey.percent_yes, precision: 1)
  end

  def survey_formated_created_at(survey)
    survey.created_at.strftime('%B %d, %Y at %I:%M %p')
  end
end
