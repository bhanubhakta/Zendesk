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
    rescue Exception => e
      raise e
    end
    instances
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
    begin
      field_value.each do |field, value|
        results += instances.select do |instance|
          field_val = instance[field.to_s]
        
          if value.to_s.strip == ''
            field_val.to_s == value.to_s
          else
            case self.class::DATATYPES[field]
            when 'integer'
              field_val.to_s == value.to_s
            when 'datetime'
              # This can be preety complicated
              # afterwards; especially when comparison
              # has to be made.
              field_val.to_s == value.to_s
            else
              field_val.to_s.downcase.include? value.to_s.downcase
            end
          end
        end
      end
    rescue Exception => e
      raise e
    end
    results
  end
end
