# frozen_string_literal: true

# Ticket domain class.
class Ticket < Base
  # This ticket is using file as a data source
  FILE_NAME = File.expand_path('../../data_source/tickets.json', __FILE__)
  DATATYPES = {
    '_id': 'integer',
    'url': 'string',
    'external_id': 'string',
    'created_at': 'datetime',
    'type': 'string',
    'subject': 'string',
    'description': 'string',
    'priority': 'string',
    'status': 'string',
    'submitter_id': 'integer',
    'assignee_id': 'integer',
    'organization_id': 'integer',
    'tags': 'array',
    'has_incidents': 'boolean',
    'due_at': 'datetime',
    'via': 'web'
  }.freeze

  attr_accessor :_id, :url, :external_id, :created_at,
                :type, :subject, :description, :priority,
                :status, :submitter_id, :assignee_id,
                :organization_id, :tags, :has_incidents,
                :due_at, :via
end
