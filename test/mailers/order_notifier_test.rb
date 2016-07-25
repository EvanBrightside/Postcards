require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase

  test "received" do
    mail = OrderNotifier.received(orders(:one))
    assert_equal "Order confirmation in Postcards Store", mail.subject
    assert_equal ["xvanx84@gmail.com"], mail.to
    assert_equal ["info@postcards.io"], mail.from
    assert_match /1 x Hawaii/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "Order from the Postcards Store sent", mail.subject
    assert_equal ["xvanx84@gmail.com"], mail.to
    assert_equal ["info@postcards.io"], mail.from
    assert_match /<td>1&times;<\/td>\s*<td>Hawaii<\/td>/, mail.body.encoded
  end
end
