# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Lexeme, type: :model do
  before do
    create(:lexeme)
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:body).is_at_most(50) }
    it { is_expected.to validate_uniqueness_of(:body).scoped_to(:language_id) }
  end
end
