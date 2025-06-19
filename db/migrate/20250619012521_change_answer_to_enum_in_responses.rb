# frozen_string_literal: true

# ChangeAnswerToEnumInResponses
class ChangeAnswerToEnumInResponses < ActiveRecord::Migration[7.1]
  def up
    change_column :responses, :answer, :integer
  end

  def down
    change_column :responses, :answer, :boolean
  end
end
