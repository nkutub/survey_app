# frozen_string_literal: true

# == Schema Information
#
# Table name: responses
#
#  id         :integer          not null, primary key
#  survey_id  :integer          not null
#  answer     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Response model
class Response < ApplicationRecord
  belongs_to :survey

  enum answer: {
    no: 0,
    yes: 1
  }

  validates :answer, presence: true
end
