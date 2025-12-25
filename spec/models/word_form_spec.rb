# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WordForm, type: :model do
  before do
    create(:word_form)
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:word_id).scoped_to(:lexeme_id) }
  end
end
