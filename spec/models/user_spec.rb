require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "It needs to be created with password and password_confirmation" do
      @user = User.new(first_name: "user_test", email: "john@john.com", password: "john123", password_confirmation: "john123")
      @user.save!
      expect(@user).to be_present
    end

    it "should error if passwords dont match" do
      @user = User.new(first_name: "user_test", email: "john@john.com", password: "john123", password_confirmation: "haha")
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "will not save with nil password" do
      @user = User.new(first_name: "John", email: "john@john.com", password: nil, password_confirmation: "john123")
      @user.save
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "will not save with nil password_confirmation" do
      @user = User.new(first_name: "John", email: "john@john.com", password: "john123", password_confirmation: nil)
      expect(@user.id).not_to be_present
    end

    it "should have a unique email" do
      @user1 = User.new(first_name: "john", email: "john@john.com", password: "john123", password_confirmation: "john123")
      @user2 = User.new(first_name: "john", email: "john@john.com", password: "john123", password_confirmation: "john123")
      @user1.save
      @user2.save
      expect(@user2.id).not_to be_present
    end

    it "should have an email case sensitive" do
      @user1 = User.new(first_name: "john", email: "john@john.com", password: "john123", password_confirmation: "john123")
      @user2 = User.new(first_name: "john", email: "JOHN@JOHN.com", password: "john123", password_confirmation: "john123")
      @user1.save
      @user2.save
      expect(@user2.id).not_to be_present
    end

    it "should not save if any field is not filled out" do
      @user1 = User.new(first_name: nil, email: "john@john.com", password: "john123", password_confirmation: "john123")
      @user2 = User.new(first_name: "john", email: nil, password: "john123", password_confirmation: "john123")
      @user3 = User.new(first_name: "john", email: "john@john.com", password: nil, password_confirmation: "john123")
      @user1.save
      @user2.save
      @user3.save
      expect(@user1.id).to be nil
      expect(@user2.id).to be nil
      expect(@user3.id).to be nil
    end

    it "The password needs to have at least 3 characters." do
      @user1 = User.new(first_name: "john", email: "john@johncom", password: "j", password_confirmation: "j")
      @user1.save
      expect(@user1.id).not_to be_present
    end
  end

  describe '.authenticate_with_credentials' do
    before(:each) do 
      @email = "john@john.com"
      @password = "john123"
      user = User.create(first_name:"john", email: @email, password: @password, password_confirmation: @password)
    end

    describe "test(:each)" do 
      it "should eliminate unwanted extra spaces before and after the email" do
        user = User.authenticate_with_credentials("    john@john.com    ", @password)
        expect(user).to be_a(User)
      end
    end

    describe "test(:each)" do 
      it "will return nil when given the wrong user_name" do
        user = User.authenticate_with_credentials("haha@haha.com", @password)
        expect(user).to eq(nil)
      end
    end

    describe "test(:each)" do 
      it "will return nil when given an invalid password" do
        user = User.authenticate_with_credentials(@email, "sadasd21")
        expect(user).to eq(nil)
      end
    end

    describe "test(:each)" do 
      it "will return a user when given the username with case sensitive characters" do
        user = User.authenticate_with_credentials("JoHn@JOHN.com", @password)
        expect(user).to be_a(User)
      end
    end

    describe "test(:each)" do 
      it "will return a nil when given a valid case-insensitive password" do
        user = User.authenticate_with_credentials("Hafe@wef.com", "EQWF4567")
        expect(user).to eq(nil)
      end
    end
  end
end




