require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def test_save_user_without_parameters 
    user = User.new
    assert_not user.save, "User saved without parameters"
  end

  def test_save_user
   assert create(:user), "User not saved"
  end

  def test_save_user_without_email
    user = build(:user, email: "")
    assert_not user.save, "User saved without email"
  end

  def test_save_user_with_incorrect_email
    user = build(:user, email: Faker::Lorem.characters(number: 10))
    assert_not user.save
  end

  def test_save_user_without_password
    user = build(:user, password: "")
    assert_not user.save, "User saved without email"
  end

  def test_save_user_without_username
    user = build(:user, username: "")
    assert_not user.save, "User saved without email"
  end

  def test_save_user_with_same_username
    user = build(:user)
    user.save
    second = build(:user, username: user[:username])
    assert_not second.save, "User saved with username already used"
  end
end
