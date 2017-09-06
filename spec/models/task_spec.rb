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
    
    it 'titleは最大200文字入力できる' do
      user = create(:user)
      task = build(:task)
      task.user_id = user.id
      task.title = 'a' * 201
      task.valid?
      expect(task.errors[:title].present?).to be true
      
      task.title = 'a' * 200
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

      context 'title, contentに[keyword_no_q]が含まれない場合はタスクは取得できない' do
        subject { Task.by_q('keyword_no_q') }
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

    describe 'by_checked' do
      let!(:user) { create(:user) }
      let!(:task) { user.tasks.create({title: 'title keyword_title', content: 'content keyword_content'}) }
      
      context 'まだチェックされていない(checked = false)のタスクを取得する' do
        subject { Task.by_checked(false) }
        it { is_expected.to include task }
      end
      
      context 'チェックされたタスクは取得できない' do
        subject { Task.by_checked(true) }
        it { is_expected.not_to be include task }
      end

      context 'boolean以外を指定された場合はtrueとし、チェックされたタスクがないので取得できない' do
        subject { Task.by_checked('aaaa') }
        it { is_expected.not_to be include task }
      end
    end
    
    describe 'by_next_days' do
      let(:user) { create(:user) }
      let(:task_5_days_since) { user.tasks.create({
          title: '現在日時から5日後のタスク',
          content: 'content keyword_content',
          due_to: 5.days.since
        }) 
      }
      let(:task_7_days_since) { user.tasks.create({
          title: '現在日時から7日後のタスク',
          content: 'content keyword_content',
          due_to: 7.days.since.end_of_day
        }) 
      }
      
      context 'タスクの期限が現在時刻から7日後以降のタスクを取得する' do
        subject { Task.by_next_days(7) }
        it { is_expected.to include task_5_days_since }
        it { is_expected.to include task_7_days_since }
      end
      
      context 'タスクの期限が現在時刻から6日後以降のタスクは取得できない' do
        subject { Task.by_next_days(6) }
        it { is_expected.to include task_5_days_since }
        it { is_expected.not_to include task_7_days_since }
      end
      
      context 'by_next_daysにinteger以外を指定するとタスクを取得できない' do
        subject { Task.by_next_days('aaaa') }
        it { is_expected.not_to include task_5_days_since }
        it { is_expected.not_to include task_7_days_since }
      end
    end
    
    
    describe 'by_expired' do
      let!(:user) { create(:user) }
      let(:task_5_days_before) { user.tasks.create({
          title: '現在日時から5日前のタスク',
          content: 'content keyword_content',
          due_to: 5.days.before
        }) 
      }
      let(:task_7_days_since) { user.tasks.create({
          title: '現在日時から7日後のタスク',
          content: 'content keyword_content',
          due_to: 7.days.since.end_of_day
        }) 
      }
      
      context '期日が過ぎている(due_to < 現在時刻)タスクを取得する' do
        subject { Task.by_expired(true) }
        it { is_expected.to include task_5_days_before }
        it { is_expected.not_to include task_7_days_since }
      end

      context '期日が過ぎていない(due_to > 現在時刻)タスクを取得する' do
        subject { Task.by_expired(false) }
        it { is_expected.not_to include task_5_days_before }
        it { is_expected.to include task_7_days_since }
      end

      context 'by_expiredにboolean以外を指定した場合は、期日が過ぎているタスクを取得する' do
        subject { Task.by_expired('aaa') }
        it { is_expected.to include task_5_days_before }
        it { is_expected.not_to include task_7_days_since }
      end
    end   
    
  end
end
