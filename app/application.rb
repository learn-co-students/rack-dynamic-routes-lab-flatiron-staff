class Application

  def call(env)
    res = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item = req.path.split("/items/").last
      found = item ? Item.items.find { |i| i.name == item } : nil

      if found
        res.write "#{found.name} costs #{found.price}"
      else
        res.write 'Item not found'
        res.status = 400
      end
    else
      res.write 'Route not found'
      res.status = 404
    end

    res.finish
  end

end
