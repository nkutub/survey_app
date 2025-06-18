# frozen_string_literal: true

# == Schema Information
#
# Table name: responses
#
#  id         :integer          not null, primary key
#  survey_id  :integer          not null
#  answer     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :response do
    survey { create(:survey) }
    answer { false }
  end
  factory :yes_response, class: Response do
    survey { create(:survey) }
    answer { true }
  end
  factory :no_response, class: Response do
    survey { create(:survey) }
    answer { false }
  end
end
