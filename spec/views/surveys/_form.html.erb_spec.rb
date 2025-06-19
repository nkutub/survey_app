# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'surveys/_form', type: :view do
  before do
    render partial: 'surveys/form'
  end

  it 'renders the new survey form' do
    assert_select 'form[action=?][method=?]', surveys_path, 'post' do
      assert_select 'textarea[name=?]', 'survey[question]'
      assert_select 'input[type=?][value=?]', 'submit', 'Create Survey'
    end
  end

  it 'has the correct form elements with Bootstrap classes' do
    assert_select '.card' do
      assert_select '.card-body' do
        assert_select 'form.row' do
          assert_select 'textarea.form-control'
          assert_select 'input.btn.btn-primary[type=?]', 'submit'
        end
      end
    end
  end
end
