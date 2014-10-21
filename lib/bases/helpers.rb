# encoding: UTF-8

# Some miscellaneous helper functions.
module Bases::Helpers
  # Return `true` if there are duplicate elements in `ary`.
  # @param [Array] ary
  # @return [bool]
  def self.are_there_duplicates?(ary)
    ary.uniq.size != ary.size
  end

  # Return an array version of `base`. An *array version* of `base` means an
  # array of **strings**. If `base` is already an array, a copy of that array
  # but with all elements converted to strings is returned. If `base` is an
  # integer (in base 10 :D) a range-like array going from 0 to `base` is
  # returned.
  # @param [Integer|Array] base
  # @return [Array<String>]
  # @raise [DuplicateDigitsError] if there are duplicate digits in the base (if
  #   it was passed as an array).
  def self.base_to_array(base)
    base = (base.is_a?(Array) ? base : (0...base)).map(&:to_s)

    if are_there_duplicates?(base)
      fail Bases::DuplicateDigitsError,
        'There are duplicate digits in the base'
    else
      base
    end
  end

  # Check whether `digits` contains some digits that are not in `base`.
  # @param [Array<String>] digits An array of digits
  # @param [Array] base The base expressed as an array as everywhere else
  # @return [boolean]
  def self.only_valid_digits?(digits, base)
    digits.all? { |digit| base.include?(digit) }
  end
end
