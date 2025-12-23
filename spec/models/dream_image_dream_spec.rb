# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DreamImageDream, type: :model do
  before do
    create(:dream_image_dream)
  end

  it { is_expected.to belong_to(:dream_image).counter_cache(:dreams_count) }
  it { is_expected.to belong_to(:dream) }

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:dream_image_id).scoped_to(:dream_id) }
  end

  describe 'ownership constraints' do
    let(:dream) { create(:dream) }
    let(:dream_image) { create(:dream_image) }
    let(:entity) { build(:dream_image_dream, dream:, dream_image:) }

    it 'validates that dream and image owners match', :aggregate_failures do
      expect(entity).not_to be_valid
      expect(entity.errors.messages).to have_key(:dream_image)
    end
  end
end
