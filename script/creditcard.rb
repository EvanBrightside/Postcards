credit_card = ActiveMerchant::Billing::CreditCard.new(
    number: '4111111111111111',
    month: '8',
    year: '2009',
    first_name: 'Tobias',
    last_name: 'Luetke',
    verification_value: '123'
)
puts "Действительна ли карта #{credit_card.number}? #{credit_card.valid?}"
