require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  def setup
  @base_title = "Ruby on Rails Tutorial Sample App"
  end
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "#{@base_title}"
  end
  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end
  test "should get about" do
	get :about
	assert_response :success
  assert_select "title", "About | #{@base_title}"
end
  test "should get contact" do
  get :contact
  assert_response :success
  assert_select "title", "Contact | #{@base_title}"
  assert_select "h3", "Our Location"
end
test "should get resume" do
  get :resume
  assert_response :success
  assert_select "title", "Resume | #{@base_title}"
  assert_select "h1", "Curriculum Vitae"
  assert_select "h2", "Personal Details"
  assert_select "p", "Name: Musa Omondi"
  assert_select "h2", "Education"
  assert_select "h3", "Maseno univesity"
  assert_select "p","Bsc Computer Science"
  assert_select "h2", "Hobbies"
  assert_select "li", "Playing Badminton"
  assert_select "h2", "Referee"
  
  end

end
