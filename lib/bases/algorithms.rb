# encoding: UTF-8

# This module encapsulates the practical algorithms used to change bases.
module Bases::Algorithms
  # The common base conversion algorithm, which converts a number in base 10
  # (`value`) to its value in base `new_base`.
  # @param [Integer] value The value in base 10
  # @param [Array<String>] new_base
  # @return [Array<String>] An array of digits (as strings) from the most
  #   significant to the least significant one
  def self.convert_to_base(value, new_base)
    # Return early if the is 0, as it is the first digit of the base array.
    return [new_base.first] if value == 0

    result = []
    numeric_base = new_base.count

    while value > 0
      remainder = value % numeric_base
      value /= numeric_base
      result.unshift(new_base[remainder])
    end

    result
  end

  # Convert a value in a source base to an integer in base 10.
  # @param [Array<String>] digits_ary An array of digits, from the most
  #   significant to the least significant.
  # @param [Array<String>] source_base A base expressed as a list of digits
  # @return [Integer]
  def self.convert_from_base(digits_ary, source_base)
    # The numeric base is the number of digits in the source base.
    numeric_base = source_base.count

    digits_ary.reverse.each.with_index.reduce(0) do |value, (digit, position)|
      #  The value of `digit` in the source base is simply the index of `digit`
      #  in the `@source_base` array.
      digit_value_in_base10 = source_base.find_index(digit)
      value + (digit_value_in_base10 * (numeric_base**position))
    end
  end
end
