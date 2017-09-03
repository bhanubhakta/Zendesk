# frozen_string_literal: true
unless defined?(Search)
  require File.expand_path('../../lib/search.rb', __FILE__)
end

# class to search tickets.
class TicketSearch < Search
  attr_accessor :organizations, :users

  # Public: Initialize ticket search. ticket and user are
  # injected to this class as there is relationship.
  #
  # field_value: The {field: value} hash that has to be searched.
  #
  # Initializes the ticket search object.
  def initialize(field_value)
    @organizations = Organization.new
    @users = User.new
    super('Ticket', field_value)
  end

  # Public: organization associated with a ticket result.
  #
  # Examples
  #
  #   organization
  #   # => return associated organization.
  #
  # Returns associated organization for the ticket.
  def organization
    records do |instance|
      instance['organization'] = organizations.where('_id': instance['organization_id']).last
    end
  end

  # Public: assignee associated with a ticket result.
  #
  # Examples
  #
  #   assignee
  #   # => return associated assignee.
  #
  # Returns associated assignee for the ticket.
  def assignee
    records do |instance|
      instance['assignee'] = users.where('_id': instance['assignee_id']).last
    end
  end

  # Public: submitter associated with a ticket result.
  #
  # Examples
  #
  #   submitter
  #   # => return associated submitter.
  #
  # Returns associated submitter for the ticket.
  def submitter
    records do |instance|
      instance['submitter'] = users.where('_id': instance['submitter_id']).last
    end
  end

  def load_relations
    organization
    submitter
    assignee
  end

  # Print the records in human readable format.
  def preetify
    preety_print do |instance|
      org = instance['organization'] || { 'name' => 'N/A' }
      puts 'organization_name'.to_s.ljust(30) + org['name']

      %w(submitter assignee).each do |user_key|
        user = instance[user_key] || { 'name' => 'N/A' }
        puts user_key.ljust(30) + user['name']
      end
    end
  end
end
