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
  # Add Kaminari pagination
  paginates_per 6

  has_many :responses, dependent: :destroy
  validates :question, presence: true

  def percent_yes
    return 0 if responses.none?

    (responses.yes.count.to_f / responses.count * 100).round(2)
  end

  def percent_no
    return 0 if responses.none?

    (responses.no.count.to_f / responses.count * 100).round(2)
  end
end
