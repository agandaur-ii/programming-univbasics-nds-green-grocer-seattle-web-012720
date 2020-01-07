def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  
  index = 0
  while index < collection.length do 
    if collection[index].value?(name) == true 
      return collection[index]
    else
      index += 1
    end
  end
end

def create_array_of_items(cart)
  array_of_items = []
  index = 0 
  while index < cart.length do
    array_of_items << cart[index][:item]
    index += 1
  end 
  array_of_items
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
  consolidated_cart = cart.uniq
  full_item_list = create_array_of_items(cart)
  item_count = full_item_list.each_with_object(Hash.new(0)) { |word,counts| counts[word] += 1 }
  index = 0
  while index < consolidated_cart.length do 
    consolidated_cart[index][:count] = item_count[consolidated_cart[index][:item]]
    index += 1
  end
  consolidated_cart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
   if coupons == []
    return cart
  end  
  
  list_of_items = create_array_of_items(cart)
  couponed_items = create_array_of_items(coupons)
  c_index = 0
  while c_index < couponed_items.length do
    l_index = 0
    while l_index < list_of_items.length do 
      if couponed_items[c_index] == list_of_items[l_index]
        with_coupon_hash = {}
        with_coupon_hash[:item] = "#{couponed_items[c_index]} W/COUPON"
        with_coupon_hash[:price] = coupons[c_index][:cost] / coupons[c_index][:num]
        with_coupon_hash[:clearance] = cart[l_index][:clearance]
        with_coupon_hash[:count] = coupons[c_index][:num]
  
        cart[l_index][:count] -=  coupons[c_index][:num]
        l_index += 1
        
        check_index = 0 
         while check_index < cart.length do
           if with_coupon_hash == cart[check_index]
             t_f_list = []
             t_f_list << "Don't process"
             check_index += 1
           end
           check_index += 1
         end

         if t_f_list == nil
           cart << with_coupon_hash
         else 
           puts "Coupon already redeemed"
         end
      else
      l_index += 1
      end  
    end
    c_index += 1
  end
  final_index = 0 
  #while final_index < cart.length do 
    if cart[final_index][:count] != 0 
      final_index += 1 
    else 
      cart.delete_at(final_index)
    end  
  #end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  index = 0 
  while index < cart.length do 
    if cart[index][:clearance] == true
      twenty_percent = cart[index][:price] / 5
      cart[index][:price] -= twenty_percent
    end
    index += 1
  end
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  consolidate = consolidate_cart(cart)
  coupons = apply_coupons(consolidate, coupons)
  clearance = apply_clearance(coupons)
  
  total = 0 
  index = 0 
  while index < clearance.length do
    total += clearance[index][:price] * clearance[index][:count]
    index += 1
  end  
  
  if total <= 100 
    return total
  end
  ten_percent = total / 10
  final = total - ten_percent
  final
end
