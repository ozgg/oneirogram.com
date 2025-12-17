# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dream, type: :model do
  before do
    create(:dream)
  end

  it_behaves_like 'has_uuid'

  it { is_expected.to belong_to(:sleep_place).optional }
  it { is_expected.to belong_to(:user).optional }
  # it { is_expected.to have_many(:dream_interpretations) }
  # it { is_expected.to have_many(:dream_personal_patterns) }
  # it { is_expected.to have_many(:personal_patterns).through(:dream_personal_patterns) }
  it { is_expected.to define_enum_for(:privacy).with_values(%i[generally_accessible for_community personal]) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:body).is_at_least(20).is_at_most(50_000) }
    it { is_expected.to validate_presence_of(:lucidity) }
    it { is_expected.to validate_numericality_of(:lucidity).is_in(0..5) }
    it { is_expected.to validate_presence_of(:privacy) }
    it { is_expected.to validate_length_of(:title).is_at_most(200) }
  end

  describe 'sleep place validation' do
    let(:dream) { build(:dream) }

    it 'passes when sleep place is not set' do
      dream.sleep_place = nil
      expect(dream).to be_valid
    end

    context 'when dream is anonymous' do
      before do
        dream.user = nil
      end

      it 'fails when sleep place is set', :aggregate_failures do
        dream.sleep_place = create(:sleep_place)
        expect(dream).not_to be_valid
        expect(dream.errors.messages).to have_key(:sleep_place)
      end
    end

    context 'when dream is not anonymous' do
      let(:dream) { build(:dream, user: create(:user)) }

      it 'passes when sleep place has the same owner' do
        dream.sleep_place = create(:sleep_place, user: dream.user)
        expect(dream).to be_valid
      end

      it 'fails when sleep place has other owner', :aggregate_failures do
        dream.sleep_place = create(:sleep_place)
        expect(dream).not_to be_valid
        expect(dream.errors.messages).to have_key(:sleep_place)
      end
    end
  end
end
