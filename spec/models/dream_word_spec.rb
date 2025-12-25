# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DreamWord, type: :model do
  before do
    create(:dream_word)
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:word_id).scoped_to(:dream_id) }
  end
end
