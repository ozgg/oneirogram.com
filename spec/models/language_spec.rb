# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Language, type: :model do
  before do
    create(:language)
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_uniqueness_of(:code) }
    it { is_expected.to validate_length_of(:code).is_at_least(2).is_at_most(35) }
  end
end
