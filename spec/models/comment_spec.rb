# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    create(:comment)
  end

  it_behaves_like 'has_uuid'

  it { is_expected.to belong_to(:user).optional }
  it { is_expected.to belong_to(:browser).optional }
  it { is_expected.to belong_to(:parent).optional }
  it { is_expected.to have_many(:child_comments).dependent(:destroy) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:body).is_at_most(5000) }
    it { is_expected.to validate_presence_of(:commentable_uuid) }
    it { is_expected.to validate_presence_of(:commentable_type) }
  end
end
