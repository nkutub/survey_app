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
# Survey model
class Survey < ApplicationRecord
  validates :question, presence: true

  has_many :responses

  def percent_yes
    response_count = responses.count.to_f
    return 0 if response_count.zero?

    (responses.where(answer: true).count / response_count) * 100
  end
end
