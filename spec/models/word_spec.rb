# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Word, type: :model do
  before do
    create(:word)
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:body) }
  end

  describe 'normalization' do
    it 'casts body to lower case' do
      word = described_class.new(body: 'Image')
      expect(word.body).to eq('image')
    end

    it 'truncates body to 50 letters' do
      word = described_class.new(body: 'a' * 51)
      expect(word.body.length).to eq(50)
    end
  end
end
