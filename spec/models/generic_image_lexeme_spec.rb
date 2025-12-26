# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GenericImageLexeme, type: :model do
  before do
    create(:generic_image_lexeme)
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:lexeme_id).scoped_to(:generic_image_id) }
  end
end
