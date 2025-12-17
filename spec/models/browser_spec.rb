# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Browser, type: :model do
  before do
    create(:browser)
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe '[]' do
    context 'when name is nil' do
      it 'returns nil' do
        expect(described_class[nil]).to be_nil
      end
    end

    context 'when name already exists' do
      let!(:browser) { create(:browser) }
      let(:action) { described_class[browser.name] }

      it 'returns existing browser' do
        expect(action.class).to be described_class
      end

      it 'does not change Browser.count' do
        expect { action }.not_to change(described_class, :count)
      end
    end

    context 'when name does not exist' do
      let(:name) { 'RSpec/1.0' }
      let(:action) { described_class[name] }

      it 'returns browser with given name' do
        expect(action.name).to eq name
      end

      it 'creates Browser' do
        expect { action }.to change(described_class, :count).by(1)
      end
    end
  end
end
