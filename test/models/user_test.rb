require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new
  end

  def test_invalid_email
    @user.email = "srgerhert+zegte45gre"
    @user.password = "playground"
    refute @user.save
  end

  def test_it_sends_a_welcome_email
    @user.email = "yo@example.com"
    @user.password = "playground"
    @user.save!
    assert ActionMailer::Base.deliveries.length == 1
    assert ActionMailer::Base.deliveries.first.to.include? @user.email
  end

end
