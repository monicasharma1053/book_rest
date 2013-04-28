require 'net/http'
 
class Api
  attr_accessor :url
  attr_accessor :uri
  
  def initialize
    @url = "http://localhost:3000/carts"
    @uri = URI.parse @url
  end
  
  # Create an employee using a predefined XML template as a REST request.
  def create(book_id="default", order_id="default")
    xml_req =
    "<?xml version='1.0' encoding='UTF-8'?>
    <cart>
      <book_id>#{book_id}</book_id>
      <order_id>#{order_id}</order_id>
    </cart>"
    
    request = Net::HTTP::Post.new(@url)
    request.add_field "Content-Type", "application/xml"
    request.body = xml_req
    
    http = Net::HTTP.new(@uri.host, @uri.port)
    response = http.request(request)
 
    response.body    
  end
  
  # Read can get all employees with no arguments or
  # get one employee with one argument.  For example:
  # api = Api.new
  # api.read 2 => one employee
  # api.read   => all employees
  def read(id=nil)
    request = Net::HTTP.new(@uri.host, @uri.port)
 
    if id.nil?
      response = request.get("#{@uri.path}.xml")      
    else
      response = request.get("#{@uri.path}/#{id}.xml")    
    end
    
    response.body
  end
  
  # Update an employee using a predefined XML template as a REST request.
  def update(id, title="Updated Title", author="Updated Author", description="Updated", price=0.00, isbn="Updated")
    xml_req =
    "<?xml version='1.0' encoding='UTF-8'?>
    <cart>
      <book_id>#{book_id}</book_id>
      <order_id>#{order_id}</order_id>
      <id type='integer'>#{id}</id>
    </cart>"
    
    request = Net::HTTP::Put.new("#{@url}/#{id}.xml")
    request.add_field "Content-Type", "application/xml"
    request.body = xml_req
    
    http = Net::HTTP.new(@uri.host, @uri.port)
    response = http.request(request)
    
    # no response body will be returned
    case response
    when Net::HTTPSuccess
      return "#{response.code} OK"
    else
      return "#{response.code} ERROR"
    end
  end
  
  # Delete an employee with an ID using HTTP Delete
  def delete(id)
    request = Net::HTTP::Delete.new("#{@url}/#{id}.xml")
    http = Net::HTTP.new(@uri.host, @uri.port)
    response = http.request(request)
    
    # no response body will be returned
    case response
    when Net::HTTPSuccess
      return "#{response.code} OK"
    else
      return "#{response.code} ERROR"
    end
  end
    
end