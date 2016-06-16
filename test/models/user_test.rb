require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@user=User.new(name: "EXample User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
	end
  test "should be valid" do
  assert @user.valid?
  end
  test "name should be present" do
  	@user.name="  "
  	assert_not @user.valid?
  end
  test "email should be present" do
  	@user.email=" "
  	assert_not @user.valid?
  end
  test "name should not be too long" do
  	@user.name ="a"*51
  	assert_not @user.valid?
  end
  test "email should not be too long" do
  	@user.email="a"*244 + "@example.com"
  end
  test "email validation should accept valid addresses" do
  	valid_addresses=%w[user@example.com USER@foo.COM A_US_ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
  	valid_addresses.each do |valid_address|
  		@user.email = valid_address
  		assert @user.valid?, "#{valid_address.inspect} should be valid"
  	end
  end
  test "email validation should reject invalid addresses" do
  	invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
  	invalid_addresses.each do |invalid_address|
  		@user.email = invalid_address
		assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
		end
	end
	test "email addresses should be unique" do
		dublicate_user=@user.dup
		dublicate_user.email = @user.email.upcase
		@user.save
		assert_not dublicate_user.valid?
	end
  test "password should have a minimum length" do
    @user.password =@user.password_confirmation = "a"*5
  end
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end
  test "should follow and unfollow a user" do 
    michael = users(:michael)
    archer = users(:archer)
    assert_not michael.following?(archer)
    michael.follow(archer)
    assert michael.following?(archer)
    assert archer.followers.include?(michael)
    michael.unfollow(archer)
    assert_not michael.following?(archer)
  end
end
