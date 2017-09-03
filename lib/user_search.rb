# frozen_string_literal: true
unless defined?(Search)
  require File.expand_path('../../lib/search.rb', __FILE__)
end

# class to search users.
class UserSearch < Search
  attr_accessor :orgs, :tickets

  # Public: Initialize user search. orgs and tickets are
  # injected to this class as there is relationship.
  #
  # field_value: The {field: value} hash that has to be searched.
  #
  # Initializes the user search object.
  def initialize(field_value)
    @orgs = Organization.new
    @tickets = Ticket.new
    super('User', field_value)
  end

  # Public: organizations associated with a user result.
  #
  # Examples
  #
  #   organizations
  #   # => return associated organizations.
  #
  # Returns associated organizations for the user.
  def organizations
    records do |instance|
      instance['organization'] = orgs.where('_id': instance['organization_id']).last
    end
  end

  # Public: submitted tickets by a user.
  #
  # Examples
  #
  #   submitted_tickets
  #
  # Returns the user submitted tickets.
  def submitted_tickets
    records do |instance|
      instance['submitted_tickets'] = tickets.where('submitter_id': instance['_id'])
    end
  end

  # Public: worked tickets by user.
  #
  # Examples
  #
  #   worked_tickets
  #
  # Returns tickets that are worked by user.(assignee)
  def worked_tickets
    records do |instance|
      instance['assigned_tickets'] = tickets.where('assignee_id': instance['_id'])
    end
  end

  def load_relations
    organizations
    submitted_tickets
    worked_tickets
  end

  # Public: Print the preetified format of the records.
  #
  # Examples
  #
  #   preetify
  #
  # prints the records.
  def preetify
    preety_print do |instance|
      puts 'organization_name'.ljust(30) + instance['organization']['name'].to_s
      %w(submitted_tickets assigned_tickets).each do |tickt|
        instance[tickt].each_with_index do |ticket, index|
          puts "#{tickt}_#{index}".to_s.ljust(30) + ticket['subject'].to_s
        end
      end
    end
  end
end
