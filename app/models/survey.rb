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
    return 0 if responses.none?

    (responses.yes.count.to_f / responses.count * 100).round(2)
  end
end
