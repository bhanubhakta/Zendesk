# frozen_string_literal: true

unless defined?(Search)
  require File.expand_path('../../lib/search.rb', __FILE__)
end

# class to search organizations.
class OrganizationSearch < Search
  attr_accessor :ticket, :user

  # Public: Initialize organization search. ticket and user are
  # injected to this class as there is relationship.
  #
  # field_value: The {field: value} hash that has to be searched.
  #
  # Initializes the organization search object.
  def initialize(field_value)
    @ticket = Ticket.new
    @user = User.new
    super('Organization', field_value)
  end

  # Public: tickets associated with a organization result.
  #
  # Examples
  #
  #   tickets
  #   # => return associated tickets.
  #
  # Returns associated tickets for the organization.
  def tickets
    records do |instance|
      instance['tickets'] = ticket.where('organization_id': instance['_id'])
    end
  end

  # Public: users associated with a organization result.
  #
  # Examples
  #
  #   users
  #   # => return associated users.
  #
  # Returns associated users for the organization.
  def users
    records do |instance|
      instance['users'] = user.where('organization_id': instance['_id'])
    end
  end

  def load_relations
    tickets
    users
  end

  # Print the records in human readable format.
  def preetify
    preety_print do |instance|
      instance['users'].each_with_index do |user, index|
        puts "user_#{index}".to_s.ljust(30) + user['name'].to_s
      end

      instance['tickets'].each_with_index do |ticket, index|
        puts "ticket_#{index}".to_s.ljust(30) + ticket['subject'].to_s
      end
    end
  end
end
