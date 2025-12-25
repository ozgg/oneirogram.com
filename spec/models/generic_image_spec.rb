# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GenericImage, type: :model do
  before do
    create(:generic_image)
  end

  it_behaves_like 'has_uuid'

  it { is_expected.to belong_to(:language) }
  it { is_expected.to have_many(:dream_generic_images).dependent(:destroy) }
  it { is_expected.to have_many(:dreams).through(:dream_generic_images) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:language_id).case_insensitive }
    it { is_expected.to validate_length_of(:summary).is_at_most(200) }
  end
end
