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
end
