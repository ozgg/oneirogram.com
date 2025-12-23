# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DreamImage, type: :model do
  before do
    create(:dream_image)
  end

  it_behaves_like 'has_uuid'

  it { is_expected.to belong_to(:user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:user_id) }
  end
end
