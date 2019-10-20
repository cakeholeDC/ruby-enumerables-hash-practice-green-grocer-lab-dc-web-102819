def consolidate_cart(cart)
  cart_hash = {}
  cart.each do |product|

    if cart_hash[product.keys[0]]
      cart_hash[product.keys[0]][:count] += 1
      #puts "Increased count to #{cart_hash[product.keys[0]][:count]}"
    
    else
      cart_hash[product.keys[0]] = {
        :price => product.values[0][:price],
        :clearance => product.values[0][:clearance],
        :count => 1
      }
      #puts "Count created with value #{cart_hash[product.keys[0]][:count]}"
    end
  end
  cart_hash #=> returns cart_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|

    if cart.keys.include? coupon[:item]
      if cart[coupon[:item]][:count] >= coupon[:num]
        newItem = "#{coupon[:item]} W/COUPON"
        if cart[newItem]
          cart[newItem][:count] += coupon[:num]
        else
          cart[newItem] = {
            :price => coupon[:cost] / coupon[:num],
            :clearance => cart[coupon[:item]][:clearance],
            :count => coupon[:num]
          }
        end #=> if coupon has aleady been applied
        cart[coupon[:item]][:count] -= coupon[:num]
      end #=> if coupon qty is valid to apply
    end #=> if cart includes coupon item => cart.keys.include?
  end #=> coupons.each
  #puts cart
  cart
end #=> apply_coupons

def apply_clearance(cart)
  cart.keys.each do |item|
    if cart[item][:clearance]
      cart[item][:price] = cart[item][:price] - ((cart[item][:price] * 0.20).round(2))
    end
  end
  cart
end

def checkout(cart, coupons)
  checkout_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(checkout_cart, coupons)
  clearance_cart = apply_clearance(coupon_cart)
  
  #puts "clearance_cart = #{clearance_cart}"
  
  total = 0.0 #=> set init total to $0.00
  clearance_cart.keys.each do |item|
    total += clearance_cart[item][:price]*clearance_cart[item][:count]
    puts clearance_cart[item][:price]
    puts "total = #{total}"
  end
  if total > 100
    (total * 0.90).round
    puts "total greater than $100, now set to #{total}"
  end
  total
  puts "bill = #{bill}"
end
