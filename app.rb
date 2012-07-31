# all products
get "/products", provides: :json do
  content_type :json

  if products = Product.all
    products.to_a.to_json
  else
    json_status 404, "Not found"
  end
end

# show product
get "/products/:id", provides: :json do
  content_type :json

  if product = Product.find(params[:id])
    product.to_json
  else
    json_status 404, "Not found"
  end
end

# new product
post "/products", provides: :json do
  content_type :json

  product = Product.new
  if product.save
    headers["Location"] = "/products/#{product.id}"
    status 201
    product.to_json
  else
    json_status 400, product.errors.to_hash
  end
end

# update product
put "/products/:id", provides: :json do
  content_type :json

  if product = Product.find(params[:id])
    if product.update_attributes(params[:product])
      product.to_json
    else
      json_status 400, thing.errors.to_hash
    end
  else
    json_status 404, "Not found"
  end
end

# delete product
delete "/products/:id", provides: :json do
  content_type :json

  if product = Product.find(params[:id])
    product.destroy!
    status 204
  else
    json_status 404, "Not found"
  end

  get "*" do
    status 404
  end

  put_or_post "*" do
    status 404
  end

  delete "*" do
    status 404
  end

  not_found do
    json_status 404, "Not found"
  end

  error do
    json_status 500, env['sinatra.error'].message
  end
end