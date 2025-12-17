# frozen_string_literal: true

RSpec.shared_examples_for 'has_uuid' do
  it_behaves_like 'has_dynamic_default_attribute', :uuid, SecureRandom.uuid

  it { is_expected.to validate_presence_of(:uuid) }
  it { is_expected.to validate_uniqueness_of(:uuid).case_insensitive }
end
