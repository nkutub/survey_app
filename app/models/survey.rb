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

  def percent_yes
    responses.where(answer: true).count / responses.count.to_f * 100
  end
end
