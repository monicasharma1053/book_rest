require './lib/book_api.rb'
require 'nokogiri'
 
# CRUD example with an api
 
def list_books(api_object)
  puts "Current Books:"
  doc = Nokogiri::XML.parse api_object.read
  names = doc.xpath('books/book/title').collect {|e| e.text }
  puts names.join(", ")
  puts ""
end
 
api = Api.new
list_books(api)
 