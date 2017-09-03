# frozen_string_literal: true

require 'json'
require 'pry'
require 'rspec'
Dir['./*/*.rb'].each do |file|
  require file
end

p 'Welcome to Zendesk Search'
p "Type 'quit' to exit any time, Press 'Enter' to continue"

p ' Select search options'
p '  * Press 1 to search Zendesk'
p '  * Press 2 to view a list of searchable fields'
p "  * Type 'quit' to exit"

option = gets.chomp.to_i

if option == 1
  p 'Select 1) Users or 2) Tickets or 3) Organizations'
  resource = gets.chomp.to_i
  p 'Enter search term'
  search_term = gets.chomp
  p 'Enter search value'
  search_value = gets.chomp

  # This can be extracted to a seperate
  # parser; so that the parser will have
  # logic to handle complex logic for parsing
  # the user submitted inputs.
  field_value = { "#{search_term}": search_value }

  case resource
  when 1
    UserSearch.new(field_value).preetify
  when 2
    TicketSearch.new(field_value).preetify
  when 3
    OrganizationSearch.new(field_value).preetify
  else
    p 'Wrong input.'
  end
elsif option == 2
  p '*****Search users with:'
  User::DATATYPES.keys.each do |key|
    p key.to_s
  end
  p '*****Search tickets with:'
  Ticket::DATATYPES.keys.each do |key|
    p key.to_s
  end
  p '*****Search organizations with:'
  Organization::DATATYPES.keys.each do |key|
    p key
  end
elsif option == 'exit'
  exit(0)
end
