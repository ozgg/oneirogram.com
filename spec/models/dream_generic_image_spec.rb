# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DreamGenericImage, type: :model do
  before do
    create(:dream_generic_image)
  end

  it { is_expected.to belong_to(:generic_image).counter_cache(:dreams_count) }
  it { is_expected.to belong_to(:dream) }

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:generic_image_id).scoped_to(:dream_id) }
    it { is_expected.to validate_presence_of(:summary) }
    it { is_expected.to validate_length_of(:summary).is_at_most(500) }
  end
end
