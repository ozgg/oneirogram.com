# frozen_string_literal: true

RSpec.shared_examples_for 'has_required_hash_attribute' do |attribute|
  it { is_expected.to allow_values({}, { foo: :bar }).for(attribute) }
  it { is_expected.not_to allow_values(nil, 'string', 1).for(attribute) }
end
