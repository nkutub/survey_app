# frozen_string_literal: true

# == Schema Information
#
# Table name: surveys
#
#  id         :integer          not null, primary key
#  question   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :survey do
    question { 'Is your favorite color blue?' }
  end

  trait :survey_with_50_percent_yes do
    question { 'Is your favorite color blue?' }
    responses do
      [
        create(:response, survey: instance, answer: true),
        create(:response, survey: instance, answer: false)
      ]
    end
  end
end
