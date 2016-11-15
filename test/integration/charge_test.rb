require 'test_helper'

class ChargeTest < ActionDispatch::IntegrationTest

  def setup
    @helper = StripeMock.create_test_helper
    @photo = Photo.first
    @email = ENV['stripe_example_email']
    StripeMock.start
  end

  def test_card_can_be_charged
    token = @helper.generate_card_token
    send_request(token)
    assert_equal status, 200
    assert JSON.parse(response.body) == ["Successfully charged"]
  end

  # def test_card_declined
  #   token = @helper.generate_card_token(number: "4000000000000002")
  #   puts token.inspect
  #   send_request(token)
  #   # assert_equal 422, status
  #   assert JSON.parse(response.body) == [], JSON.parse(response.body)
  # end

  def teardown
    StripeMock.stop
  end

  def send_request(token)
    post '/charges',
      params: {
        id: @photo.id,
        stripeToken: token,
        stripeEmail: @email
      }
  end

end
