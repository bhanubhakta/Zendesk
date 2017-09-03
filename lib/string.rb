# frozen_string_literal: true

# For constantizing a string
class String
  def constantize
    split('::').inject(Module) { |acc, val| acc.const_get(val) }
  end
end
