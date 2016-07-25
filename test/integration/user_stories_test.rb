require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products

  test "buying a product" do
    LineItem.delete_all
    Order.delete_all
    hawaii_card = products(:hawaii)

    get "/"
    assert_response :success
    assert_template "index"

    xml_http_request :post, '/line_items', product_id: hawaii_card.id
    assert_response :success

    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal hawaii_card, cart.line_items[0].product

    get "/orders/new"
    assert_response :success
    assert_template "new"

    post_via_redirect "/orders",
                    order: { name: "Ivan Zabrodin",
                            address: "123 Drida Street",
                            email: "xvanx84@gmail.com",
                            pay_type: "Check" }
    assert_response :success
    assert_template "index"
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size

    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]

    assert_equal "Ivan Zabrodin",     order.name
    assert_equal "123 Drida Street",  order.address
    assert_equal "xvanx84@gmail.com", order.email
    assert_equal "Check",             order.pay_type

    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal hawaii_card, line_item.product

    mail = ActionMailer::Base.deliveries.last
    assert_equal ["xvanx84@gmail.com"], mail.to
    assert_equal 'Ivan Zabrodin <info@postcards.io>', mail[:from].value
    assert_equal "Order confirmation in Postcards Store", mail.subject
  end
end
