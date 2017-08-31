require 'rails_helper'

RSpec.describe User, type: :model do
  
  before :each do
    @user = User.new(
      name: 'ryskit',
      email: 'ryskit@example.com',
      password: 'password',
      password_confirmation: 'password',
      uuid: "f504ac63d55b6b0da66ef938ba5e38877c5105c329205e37d1822aa2bf3d44e8e28fb8586ea727b6b84fd06f4adbdf300ff5d23ec95a500a8310488c769ba5b1"
    )
  end
  
  it '有効なユーザーである' do
    expect(@user).to be_valid
  end
  
  describe 'name validation' do
    
    it 'nameは入力必須であること' do
      @user[:name] = nil
      @user.valid?
      expect(@user.errors[:name].present?).to be true
    end
    
    it 'nameは100文字までしか入力できないこと' do
      @user[:name] = 'a' * 101
      @user.valid?
      expect(@user.errors[:name].present?).to be true
      
      @user[:name] = 'a' * 100
      @user.valid?
      expect(@user.errors[:name].present?).to be false
    end
    
  end
  
  describe 'email validation' do
    
    it 'emailは入力必須であること' do
      @user[:email] = nil
      @user.valid?
      expect(@user.errors[:email].present?).to be true
    end
    
    it 'emailは最大255文字までしか入力できないこと' do
      # 256文字
      @user[:email] = 'a' * 244 + '@example.com'
      @user.valid?
      expect(@user.errors[:email].present?).to be true
      
      # 255文字
      @user[:email] = 'a' * 243 + '@example.com'
      @user.valid?
      expect(@user.errors[:email].present?).to be false
    end
    
    it 'メールアドレスが有効であること' do
      valid_emails = %w[
        sample@example.com
        SAMPLE@Example.COM
        D_H_H@example.com
        D-H-H@exmple.com
        D+H+H@example.com
        D+H+H@example.com
        D.H.H@example.com
        D.H.H@example.com
      ]

      valid_emails.each do |email|
        @user[:email] = email
        @user.valid?
        expect(@user.errors[:email].blank?).to be true
      end
      
    end
    
    it 'メールアドレスが無効であること' do
      invalid_emails = %w[
        sample-@example.com
        SAMPLE.@Example.COM
        D_H_H_@example.com
        D-H-H+@exmple.com
        D+H+H@exam_ple.com
        D+H+H@exam+ple.com
      ]
      
      invalid_emails.each do |email|
        @user[:email] = email
        @user.valid?
        expect(@user.errors[:email].present?).to be true
      end
    end
    
    it 'メールアドレスはユニークであること' do
      duplicate_user = @user.dup
      @user.save
      duplicate_user.valid?
      expect(duplicate_user.errors[:email].present?).to be true
    end
    
    it 'メールアドレスの英字は小文字で保存されること' do
      upper_email = "RYSKIT@EXAMPLE.COM"
      @user[:email] = upper_email
      @user.save
      expect(@user[:email]).to eq 'ryskit@example.com'
    end
  end
  
  describe 'password validation' do
    
    it 'passwordは入力必須であること' do
      @user.password = ''
      @user.valid?
      expect(@user.errors[:password].blank?).to be true
    end
    
    it 'passwordは最低6文字は入力しなければならない' do
      @user.password = 'a' * 5
      @user.valid?
      expect(@user.errors[:password].present?).to be true
      
      @user.password = 'a' * 6
      @user.valid?
      expect(@user.errors[:password].present?).to be false
    end
    
  end
  
  describe 'uuid' do

    it 'uuidは入力必須であること' do
      @user.uuid = nil 
      @user.valid?
      expect(@user.errors[:uuid].present?).to be true
    end
    
    it 'uuidは128文字であること' do
      valid_uuid = @user.uuid
      invalid_uuid = 'aaaaaaaaaaaaaaaaaaa'
      @user.uuid = invalid_uuid
      @user.valid?
      expect(@user.errors[:uuid].present?).to be true
      
      @user.uuid = valid_uuid
      @user.valid?
      expect(@user.errors[:uuid].present?).to be false
    end
    
    it 'uuidはユニークであること' do
      @user.save
      another_user = User.new(
        name: 'ryskit2',
        email: 'ryskit2@example.com',
        password: 'password',
        password_confirmation: 'password',
        uuid: @user.uuid
      )
      another_user.valid?
      expect(another_user.errors[:uuid].present?).to be true
    end
  end
end
