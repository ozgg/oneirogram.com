# frozen_string_literal: true

RSpec.shared_examples_for 'has_flat_priority' do
  subject { build(model) }

  let(:model) { described_class.to_s.underscore.to_sym }
  let!(:existing_entity) { create(model) }

  shared_examples 'assigns next priority' do
    it 'assigns next priority' do
      expect(subject.priority).to eq(existing_entity.priority + 1)
    end
  end

  it { is_expected.to validate_presence_of(:priority) }
  it { is_expected.to validate_numericality_of(:priority).is_greater_than(0).is_less_than(32_768) }

  describe 'after initialize' do
    context 'when priority is given' do
      it 'uses given priority' do
        expect(build(model, priority: 3).priority).to eq(3)
      end
    end

    context 'when priority is 1 and id is nil' do
      subject { build(model, priority: 1) }

      it_behaves_like 'assigns next priority'
    end

    context 'when priority is not given' do
      it_behaves_like 'assigns next priority'
    end

    context 'when priority of existing entity is maximum' do
      before do
        existing_entity.update!(priority: 32_767)
      end

      it 'keeps maximum priority' do
        expect(subject.priority).to eq(32_767)
      end
    end
  end
end
