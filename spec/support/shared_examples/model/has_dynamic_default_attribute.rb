# frozen_string_literal: true

RSpec.shared_examples_for 'has_dynamic_default_attribute' do |attribute, value|
  describe '#new' do
    context "when #{attribute} is given" do
      it "does not change #{attribute}" do
        expect(described_class.new(attribute => value)[attribute]).to eq(value)
      end
    end

    context "when #{attribute} is not given" do
      it "assigns #{attribute}" do
        expect(described_class.new[attribute]).to be_present
      end
    end
  end
end
