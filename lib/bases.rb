# encoding: UTF-8

# Constants
require 'bases/version'
require 'bases/constants'
# Modules
require 'bases/helpers'
require 'bases/algorithms'
# Classes
require 'bases/number'

# The main module.
module Bases
  # Create a new instance of `Number` from `value`.
  # @param [String|Integer] value A value as in `Number.new`
  # @return [Number]
  def self.val(value)
    Bases::Number.new(value)
  end

  class << self
    alias_method :[], :val
  end
end
