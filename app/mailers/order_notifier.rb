class OrderNotifier < ApplicationMailer
  default from: 'Ivan Zabrodin <info@postcards.io>'

  def received(order)
    @order = order
    mail to: order.email, subject: 'Order confirmation in Postcards Store'
  end

  def shipped(order)
    @order = order
    mail to: order.email, subject: 'Order from the Postcards Store sent'
  end
end
