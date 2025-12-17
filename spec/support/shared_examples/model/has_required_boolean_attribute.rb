# frozen_string_literal: true

RSpec.shared_examples_for 'has_required_boolean_attribute' do |attribute|
  it { is_expected.to allow_values(true, false).for(attribute) }
  it { is_expected.not_to allow_value(nil).for(attribute) }
end
