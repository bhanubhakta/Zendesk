# frozen_string_literal: true

# Base class for other models.
class Base
  attr_accessor :file_name, :instances

  def initialize
    all
  end
  # Public: Returns all the records.
  #
  # Examples
  #
  #   all
  #
  # Returns all the records.

  def all
    begin
      @instances ||= JSON.parse(File.read(self.class::FILE_NAME))
    rescue StandardError => e
      raise e
    end
    instances
  end

  def filtered(field_val, field, value)
    datatype = self.class::DATATYPES[field]
    field_val = field_val.to_s
    case datatype
    when 'integer', 'datetime'
      # This can be preety complicated
      # afterwards; especially when comparison
      # has to be made.
      field_val == value
    else
      field_val.downcase.include? value.downcase
    end
  end

  # This operator is passed here so that we can extend
  # This search for handling greater than cases. For now the
  # search is very simple.

  # Public: selects records based on certain criteria.
  #
  # field_value  - hash containing the field and the value.
  #
  # Examples
  #
  #   where({'_id': 1})
  #
  # Returns the record containing the id value 1.
  def where(field_value)
    results = []
    field_value.each do |field, value|
      results += instances.select do |instance|
        filtered(instance[field.to_s], field, value.to_s)
      end
    end
    results
  end
end
