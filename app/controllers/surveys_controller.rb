# frozen_string_literal: true

# SurveysController
class SurveysController < ApplicationController
  def index
    @surveys = Survey.all
  end
end
