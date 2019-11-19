require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ''
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = ''
    assert_not @user.valid?
  end

  test "name length should not be too long" do
    @user.name = 'a' * 55
    assert_not @user.valid?
  end

  test "email length should not be too long" do
    @user.email = 'a' * 255 + '@example.com'
    assert_not @user.valid?
  end

  test "accept valid addresses format" do
    valid_addresses = %w[user@example.com fOO@bar.com foo@bar.org]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?
    end
  end

  test "reject invalid addresses format" do
    invalid_addresses = %w[user@ userexample.com user@foo)!@c.om]
    invalid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?
    end
  end

  test "email address should be unique" do
    other_user = @user.dup
    other_user.email = @user.email.upcase
    @user.save
    assert_not other_user.valid?
  end

  test "email should be saved as downcased" do
    mixed_case_email = "FoO@bAr.com"
    @user.email = mixed_case_email
    @user.save
    @user.reload
    assert_equal mixed_case_email.downcase, @user.email
  end

  test "password shold be nonblank" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
