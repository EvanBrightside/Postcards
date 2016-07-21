require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "product attributes must be not empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
    product = Product.new(
      title: "Thailand",
      description: "beautiful",
      image_url: "thai.jpg"
    )

    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
    product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
    product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(
      title: "Thailand",
      description: "beautiful",
      price: 1,
      image_url: image_url
    )
  end

  test "image url" do
    ok = %w{ pic.jpg pic.gif pic.png PIC.JPG PIC.Jpg http://a.b.c/x/y/z/pic.gif }
    bad = %w{ pic.doc pic.gif/more pic.gif.more }

    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end

    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end
  end

  test "product is not valid without a unique title" do
    product = Product.new(
      title: products(:hawaii).title,
      description: "Postcard from Hawaii",
      price: 1.55,
      image_url: "hawaii.jpg"
    )
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end
end
