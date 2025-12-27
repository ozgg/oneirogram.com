# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DreamLexeme, type: :model do
  before do
    create(:dream_lexeme)
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:dream_id).scoped_to(:lexeme_id) }
  end
end
