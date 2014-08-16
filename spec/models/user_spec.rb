require 'spec_helper'

describe User do

  before { @user = User.new(username: "testuser",
                            password: "testuser",
                            gender: "male")
          }

  subject { @user }

  it { should respond_to(:username) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:authenticate) }
  it { should be_valid }

  # test user name
  describe "when name is not present" do
    before { @user.username = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.username = "a" * 51 }
    it { should_not be_valid }
  end

  # test password
  describe "when password is not present" do
    before do
      @user = User.new(username: "testtest", password: " ")
    end
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = "a" * 5 }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(username: @user.username) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_falsey }
    end
  end

  # test gender
  describe "when genderis not present" do
    before do
      @user = User.new(username: "testtest", password: "testuser")
    end
    it { should_not be_valid }
  end
end