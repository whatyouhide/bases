# encoding: UTF-8

module Bases
  # Base 62, the alphanumeric characters.
  B62 = (
    ('A'..'Z').to_a +
    ('a'..'z').to_a +
    (0..9).to_a
  ).map(&:to_s)

  # Base 64.
  # @see http://en.wikipedia.org/wiki/Base64.
  B64 = B62 + %w(+ /)


  # This error is thrown when an invalid value is passed to `Number`'s
  # constructor.
  InvalidValueError = Class.new(StandardError)

  # This error is thrown when you try to convert a number without a specified
  # base to another base.
  NoBaseSpecifiedError = Class.new(StandardError)

  # This error is thrown when there are digits in a value which aren't in the
  # specified source base.
  WrongDigitsError = Class.new(StandardError)

  # This error is thrown when there are duplicates digits in a base.
  # @example
  #   bad_base_3 = [0, 1, 0]
  DuplicateDigitsError = Class.new(StandardError)
end
