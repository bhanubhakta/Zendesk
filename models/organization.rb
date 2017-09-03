# frozen_string_literal: true

# Organization domain class.
class Organization < Base
  # This organization is using file as a data source
  FILE_NAME = File.expand_path('../../data_source/organizations.json', __FILE__)

  DATATYPES = {
    '_id': 'integer',
    'url': 'string',
    'external_id': 'string',
    'name': 'string',
    'domain_names': 'array',
    'created_at': 'datetime',
    'details': 'string',
    'shared_tickets': 'boolean',
    'tags': 'array'
  }.freeze

  attr_accessor :_id, :url, :external_id, :name,
                :domain_names, :created_at, :details,
                :shared_tickets, :tags
end
