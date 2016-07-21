#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
# encoding: utf-8
Product.delete_all
Product.create!(title: 'Hawaii',
  description:
    %{<p> Postcard from Hawaii </p>},
  image_url:   'hawaii.jpg',
  price: 1.55)
# . . .
Product.create!(title: 'New York',
  description:
    %{<p> Postcard from New York </p>},
  image_url: 'ny.jpg',
  price: 1.55)
# . . .

Product.create!(title: 'Sri Lanka',
  description:
    %{<p> Postcard from Sri Lanka </p>},
  image_url: 'lanka.jpg',
  price: 1.55)
