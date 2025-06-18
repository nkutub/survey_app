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
# Response model
class Response < ApplicationRecord
  belongs_to :survey
  validates :answer, inclusion: { in: [true, false] }
end
