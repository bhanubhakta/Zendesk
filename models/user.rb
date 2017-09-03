# frozen_string_literal: true

# User domain class.
class User < Base
  # This user is using file as a data source
  FILE_NAME = File.expand_path('../../data_source/users.json', __FILE__)
  DATATYPES = {
    '_id': 'integer',
    'url': 'string',
    'external_id': 'string',
    'name': 'string',
    'alias': 'string',
    'created_at': 'string',
    'active': 'boolean',
    'verified': 'boolean',
    'shared': 'boolean',
    'locale': 'string',
    'timezone': 'string',
    'last_login_at': 'datetime',
    'email': 'string',
    'phone': 'string',
    'signature': 'string',
    'organization_id': 'integer',
    'tags': 'array',
    'suspended': 'boolean',
    'role': 'string'
  }.freeze

  attr_accessor :_id, :url, :external_id, :name,
                :alias, :created_at, :active, :verified,
                :shared, :locale, :timezone, :last_login_at,
                :email, :phone, :signature, :organization_id,
                :tags, :suspended, :role
end
