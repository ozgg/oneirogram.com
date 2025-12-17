# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    create(:user)
  end

  it_behaves_like 'has_uuid'
  it_behaves_like 'has_dynamic_default_attribute', :referral_code, 'referral'

  it { is_expected.to have_secure_password }
  it { is_expected.to belong_to(:inviter).optional }
  it { is_expected.to have_many(:invitees) }

  describe 'validations' do
    it_behaves_like 'has_required_boolean_attribute', :active
    it_behaves_like 'has_required_boolean_attribute', :bot
    it_behaves_like 'has_required_boolean_attribute', :email_confirmed
    it_behaves_like 'has_required_hash_attribute', :profile
    it_behaves_like 'has_required_boolean_attribute', :super_user

    it { is_expected.to validate_uniqueness_of(:email).case_insensitive.allow_nil }
    it { is_expected.to validate_length_of(:email).is_at_most(200) }
    it { is_expected.to allow_value('user@example.org').for(:email) }
    it { is_expected.not_to allow_value('not-a-email').for(:email) }
    it { is_expected.to validate_uniqueness_of(:referral_code).allow_nil }
    it { is_expected.to validate_length_of(:referral_code).is_at_least(1).is_at_most(16) }
    it { is_expected.to validate_uniqueness_of(:slug).case_insensitive }
    it { is_expected.to validate_length_of(:slug).is_at_least(1).is_at_most(24) }
    it { is_expected.to allow_value('Maxim').for(:slug) }
    it { is_expected.not_to allow_value('Who?!').for(:slug) }
  end
end
