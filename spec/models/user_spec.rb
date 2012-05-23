# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe User do
  before { @user = User.new(name: "First Name", email: "test@email.com", password: "foobar", password_confirmation: "foobar") }
  
  subject { @user }

# do these exist tests
 
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  
  it { should be_valid }
  
# name validation tests
  describe "when name isn't present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @user.name = "a"*51 }
    it { should_not be_valid }
  end

# email validation tests
  describe "when email isn't present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end
  
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end      
    end
  end
  
  describe "when email format is valid" do
    it "should be_valid" do
      addresses = %w[user@example.com CAPS@example.com under_score@example.b.org user.foo@jp.net user+b@foo.com]
      addresses.each do |valids|
        @user.email = valids
        @user.should be_valid
      end
    end
  end
  
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    
    it { should_not be_valid }
  end
  
# password validation tests
  describe "password should not be blank" do
  before { @user.password = @user.password_confirmation = " " }
  it { should_not be_valid }
  end
 
  describe "when password doesn't match confirmation" do
  before { @user.password_confirmation = "diff_password_than_foobar" }
  it { should_not be_valid }
  end
 
  describe "password confirmation can't be blank" do
  before { @user.password_confirmation = nil }
  it { should_not be_valid }
  end

# password authentication
  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end
  
  describe "password shouldn't be too short" do
      before { @user.password = @user.password_confirmation = "a"*5 }
      it { should_not be_valid }
  end
  
end
