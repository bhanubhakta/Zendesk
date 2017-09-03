# frozen_string_literal: true
# class to search. Base search.
class Search
  attr_accessor :type, :field_value, :instances

  def initialize(type, field_value)
    @type = type
    @field_value = field_value
    @instances ||= type.capitalize.constantize.new.where(field_value)
  end

  def records(*)
    @instances.each do |instance|
      yield(instance)
    end
  end

  def preety_print(*)
    p "No value exists for the #{field_value}" if instances.empty?
    instances.each do |instance|
      type.constantize::DATATYPES.keys.each do |key|
        key = key.to_s
        puts "#{key.ljust(30)} #{instance[key]}"
      end
      load_relations
      yield(instance)
      print "********************************\n"
    end
  end
end
