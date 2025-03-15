require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_inclusion_of(:completed).in_array([true, false]) }
  end

  describe 'default values' do
    it 'sets completed to false by default' do
      task = Task.new(title: 'Test Task')
      expect(task.completed).to be false
    end
  end

  describe 'soft delete' do
    let(:user) { create(:user) }
    let!(:task) { create(:task, user: user) }

    it 'sets deleted_at when soft deleted' do
      expect do
        task.soft_delete
      end.to change { task.deleted_at }.from(nil).to(be_present)
    end

    it 'excludes soft-deleted tasks from default scope' do
      task.soft_delete
      expect(Task.all).not_to include(task)
      expect(Task.unscoped.find(task.id)).to eq(task)
    end

    it 'excludes soft-deleted tasks from active scope' do
      task.soft_delete
      expect(Task.active).not_to include(task)
    end
  end
end
