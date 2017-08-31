require 'rails_helper'

RSpec.describe Task, type: :model do
  
  it '有効なタスクであること' do
    user = create(:user)
    task = build(:task)
    task.user_id = user.id
    task.valid?
    expect(task).to be_valid
  end
  
  describe 'title validation' do
    
    it 'titleは入力必須であること' do
      user = create(:user)
      task = build(:task)
      task.title = nil
      task.valid?
      expect(task.errors[:title].present?).to be true
    end
    
    it 'titleは最大50文字入力できる' do
      user = create(:user)
      task = build(:task)
      task.user_id = user.id
      task.title = 'a' * 51
      task.valid?
      expect(task.errors[:title].present?).to be true
      
      task.title = 'a' * 50
      task.valid?
      expect(task.errors[:title].present?).to be false
    end
  end
    
  describe 'content validation' do
    
    it 'contentは入力必須でない' do
      user = create(:user)
      task = build(:task)
      task.user_id = user.id
      task.content = nil
      task.valid?
      expect(task.errors[:content].blank?).to be true
    end
    
    it 'contentは最大2000文字入力できる' do
      user = create(:user)
      task = build(:task)
      task.user_id = user.id
      task.content = 'a' * 2001
      task.valid?
      expect(task.errors[:content].present?).to be true
      
      task.content = 'a' * 2000
      task.valid?
      expect(task.errors[:content].present?).to be false
    end
    
  end
  
  describe 'scope' do
    
    describe 'by_q' do
      let!(:user) { create(:user) }
      let!(:task) { user.tasks.create({title: 'title keyword_q', content: 'content keyword_q'}) }
      
      context 'title, contentに[keyword_q]が含まれるタスクを取得する' do
        subject { Task.by_q('keyword_q') }
        it { is_expected.to include task }
      end

      context 'title, contentに[keyword_not_q]が含まれない場合はタスクは取得できない' do
        subject { Task.by_q('keyword_not_q') }
        it { is_expected.not_to include task }
      end
    end
    
    describe 'by_user_id' do
      let!(:user) { create(:user) }
      let!(:task) { user.tasks.create({title: 'title keyword_q', content: 'content keyword_q'}) }
      
      context 'user_idが一致するタスクを取得する' do
        subject { Task.by_user_id(user.id) }
        it { is_expected.to include task }
      end

      context 'user_idが一致しないタスクは取得できない' do
        subject { Task.by_user_id(0) }
        it { is_expected.not_to include task }
      end

      context 'by_user_idにuser_id以外を指定した場合はタスクを取得できない' do
        subject { Task.by_user_id('aaa') }
        it { is_expected.not_to include task }
      end
    end

    describe 'by_title' do
      let!(:user) { create(:user) }
      let!(:task) { user.tasks.create({title: 'title keyword_title', content: 'content keyword_content'}) }
      
      context 'titleに[keyword_title]が含まれるタスクを取得する' do
        subject { Task.by_title('keyword_title') }
        it { is_expected.to include task }
      end

      context 'titleに[keyword_title]が含まれていない場合はタスクを取得できない' do
        subject { Task.by_title('keyword_not_title') }
        it { is_expected.not_to include task }
      end
    end
    
  end
end
