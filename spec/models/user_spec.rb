# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before :each do
      User.destroy_all
    end
    context "creating a user while password and its confirmation don't match" do
      it "should fail to save and prompt with a message 'doesn't match Password'" do
        @user = User.new(first_name: 'testy',
                         last_name: 'test',
                         email: 'test@test.com',
                         password: 'test',
                         password_confirmation: 'test1')
        expect(@user.save).to be false
        expect(@user.errors.messages[:password_confirmation])
          .to include("doesn't match Password")
      end
    end

    context 'creating a user while password or its confirmation is missing' do
      it "should fail to save and prompt with a message 'can't be blank'" do
        @user1 = User.new(first_name: 'testy',
                          last_name: 'test',
                          email: 'test@test.com',
                          password: 'test',
                          password_confirmation: nil)

        @user2 = User.new(first_name: 'testy',
                          last_name: 'test',
                          email: 'test@test.com',
                          password: nil,
                          password_confirmation: 'test')
        expect(@user1.save).to be false
        expect(@user2.save).to be false
        expect(@user1.errors.messages[:password_confirmation])
          .to include("can't be blank")
        expect(@user2.errors.messages[:password])
          .to include("can't be blank")
      end
    end

    context 'creating a user while email/first name/last name is missing' do
      it "should fail to save and prompt a message 'can't be blank' if email is missing" do
        @user = User.new(first_name: 'testy',
                         last_name: 'test',
                         email: nil,
                         password: 'test',
                         password_confirmation: 'test')
        expect(@user.save).to be false
        expect(@user.errors.messages[:email])
          .to include("can't be blank")
      end

      it "should fail to save and prompt a message 'can't be blank' if first name is missing" do
        @user = User.new(first_name: nil,
                         last_name: 'test',
                         email: 'test@test.com',
                         password: 'test',
                         password_confirmation: 'test')
        expect(@user.save).to be false
        expect(@user.errors.messages[:first_name])
          .to include("can't be blank")
      end

      it "should fail to save and prompt a message 'can't be blank' if last name is missing" do
        @user = User.new(first_name: 'test',
                         last_name: nil,
                         email: 'test@test.com',
                         password: 'test',
                         password_confirmation: 'test')
        expect(@user.save).to be false
        expect(@user.errors.messages[:last_name])
          .to include("can't be blank")
      end
    end

    context 'creating a user with an email that already exists' do
      it 'should fail to save and prompt a message "has already been taken"' do
        @user = User.new(first_name: 'test',
                         last_name: 'test',
                         email: 'TEST@TEST.COM',
                         password: 'test',
                         password_confirmation: 'test')

        @user_copy = User.new(first_name: 'testy',
                              last_name: 'testy',
                              email: 'test@test.com',
                              password: 'test',
                              password_confirmation: 'test')

        expect(@user.save).to be true
        expect(@user_copy.save).to be false
        expect(@user_copy.errors.messages[:email])
          .to include('has already been taken')
      end
    end

    context 'creating a user with password less than 4 digits ' do
      it 'should fail to save and prompt an error message' do
        @user = User.new(first_name: 'test',
                         last_name: 'test',
                         email: 'TEST@TEST.COM',
                         password: '111',
                         password_confirmation: '111')

        expect(@user.save).to be false
        expect(@user.errors.messages[:password])
          .to include('is too short (minimum is 4 characters)')
      end
    end
  end

  describe '.authenticate_with_credentials' do
    before :all do
      User.create(first_name: 'test',
                  last_name: 'test',
                  email: 'test@test.com',
                  password: 'test',
                  password_confirmation: 'test')
    end

    it 'should login successfully with correct email and password' do
      email = 'test@test.com'
      password = 'test'
      @user = User.authenticate_with_credentials(email, password)
      expect(@user.first_name).to eq('test')
      expect(@user.last_name).to eq('test')
    end

    it 'should login successfully with an email " test@test.com "' do
      email = ' test@test.com '
      password = 'test'
      @user = User.authenticate_with_credentials(email, password)
      expect(@user.first_name).to eq('test')
      expect(@user.last_name).to eq('test')
    end

    it 'should login successfully with an email "tEsT@TEst.COm"' do
      email = 'tEsT@TEst.COm'
      password = 'test'
      @user = User.authenticate_with_credentials(email, password)
      expect(@user.first_name).to eq('test')
      expect(@user.last_name).to eq('test')
    end

    it 'should login successfully with an email "tEsTaBc@TEst.COm"' do
      @user_new = User.create(first_name: 'abc',
                              last_name: 'def',
                              email: 'TESTABC@TEST.COM',
                              password: 'test',
                              password_confirmation: 'test')

      email = 'tEsTaBc@TEst.COm'
      password = 'test'
      @user = User.authenticate_with_credentials(email, password)
      expect(@user_new.email).to eq('testabc@test.com')
      expect(@user.first_name).to eq('abc')
      expect(@user.last_name).to eq('def')
    end
  end
end
