require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:michael)
	end
	test "unsuccessful edit" do
		log_in_as(@user)
		get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path(@user), user: {name: "", email: "foo@invalid", password: "foo", password_confirmation: "bar"}
		assert_template 'users/edit'
	end
	
	test "successful edit with friendly forwarding" do 
		get edit_user_path(@user)assert_redirected_to login_path
		assert_equal session[:forwarding_path], edit_user_path(@user)
		a
		log_in_as(@user)
		assert_redirected_to edit_user_path(@user)
		name = "Foo Bar"
		email = "foo@bar.com"
		patch user_path(@user), user: {name: name, email: email, password: "foobar", password_confirmation: "foobar"}
		assert_not flash.empty?
		assert_equal session[:forwarding_path], nil
		assert_redirected_to @user
		@user.reload
		assert_equal @user.name, name
		assert_equal @user.email, email
	end
end
