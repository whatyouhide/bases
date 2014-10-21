# encoding: UTF-8

# The main class provided by Bases. It represents a base-agnostic
# number which can be forced to be interpreted in any base and then converted in
# any base.
class Bases::Number
  # Create a new instance from a given `value`. If that value is an intance of a
  # subclass of `Integer` (a `Bignum` or a `Fixnum`), it will be assumed to be
  # in base 10 and any call to `in_base` on the new instance will result in an
  # exception.
  #
  # If it is a `String`, no base will be assumed; if there are spaces
  # in the string, they're used to separate the *multicharacter* digits,
  # otherwise each character is assumed to be a digit.
  #
  # It `value` is an `Array`, each element in the array is assumed to be a
  # digit. The array is read like a normal number, where digits on the left are
  # more significative than digits on the right.
  #
  # @param [Integer|String|Array] value
  # @raise [InvalidValueError] if `value` isn't a `String`, an `Integer` or an
  #   `Array`
  def initialize(value)
    case value
    when Integer
      @source_base = helpers.base_to_array(10)
      @value = value
    when String
      @digits = (value =~ /\s/) ? value.split : value.split('')
    when Array
      @digits = value.map(&:to_s)
    else
      fail Bases::InvalidValueError, "#{value} isn't a valid value"
    end
  end

  # Set the source base of the current number. The `base` can be either a number
  # (like 2 for binary or 16 for hexadecimal) or an array. In the latter case,
  # the array is considered the whole base. For example, the binary base would
  # be represented as `[0, 1]`; another binary base could be `[:a, :b]` and so
  # on.
  #
  # **Note** that when the base is an integer up to 36, the native Ruby
  # `Integer#to_i(base)` method is used for efficiency and clarity. However,
  # this means that digits in a base 36 are numbers *and* letters, while digits
  # in base 37 and more are only numbers (interpreted as multichar digits).
  #
  # `self` is returned in order to allow nice-looking chaining.
  #
  # @param [Integer|Array] base
  # @return self
  # @raise [WrongDigitsError] if there are digits in the previously specified
  #   value that are not present in `base`.
  def in_base(base)
    @source_base = helpers.base_to_array(base)

    if native_ruby_base?(base)
      @value = @digits.join('').to_i(base)
      return self
    end

    # Make sure `@digits` contains only valid digits.
    unless helpers.only_valid_digits?(@digits, @source_base)
      fail Bases::WrongDigitsError,
        "Some digits weren't in base #{base}"
    end

    @value = algorithms.convert_from_base(@digits, @source_base)
    self
  end

  # Return a string representation of the current number in a `new_base`.
  # A **string** representation is always returned, even if `new_base` is 10. If
  # you're using base 10 and want an integer, just call `to_i` on the resulting
  # string.
  #
  # @example With the default separator
  #   Number.new(3).to_base(2) #=> '11'
  # @example With a different separator
  #   Number.new(3).to_base(2, separator: ' ~ ') #=> '1 ~ 1'
  #
  # @param [Integer|Array] new_base The same as in `in_base`
  # @param [Hash] opts A small hash of options
  # @option opts [bool] :array If true, return the result as an array of digits;
  #   otherwise, return a string. This defaults to `false`.
  # @return [Array<String>|String]
  # @raise [NoBaseSpecifiedError] if no source base was specified (either by
  #   passing an integer to the constructor or by using the `in_base` method)
  def to_base(new_base, opts = {})
    opts[:array] = false if opts[:array].nil?

    unless defined?(@source_base)
      fail Bases::NoBaseSpecifiedError, 'No base was specified'
    end

    # Let's apply the base conversion algorithm, which returns an array of
    # digits.
    res = if native_ruby_base?(new_base)
            @value.to_s(new_base).split('')
          else
            algorithms.convert_to_base(@value, helpers.base_to_array(new_base))
          end

    opts[:array] ? res : res.join('')
  end

  # This function assumes you want the output in base 10 and returns an integer
  # instead of a string (which would be returned after a call to `to_base(10)`).
  # This was introduced so that `to_i` is adapted to the standard of returning
  # an integer (in base 10, as Ruby represents integers).
  # @return [Integer]
  def to_i
    to_base(10).to_i
  end

  # Specify that the current number is in hexadecimal representation.
  # @note If you want to parse an hexadecimal number ignoring case-sensitivity,
  #   you **can't** use `in_base(Bases::HEX)` since that assumes
  #   upper case digits. You **have** to use `in_hex`, which internally just
  #   calls `String#hex`.
  # @return [self]
  def in_hex
    @source_base = helpers.base_to_array(16)
    @value = @digits.join('').hex
    self
  end

  # Specify that the current number is in binary representation. This is just a
  # shortcut for `in_base(2)` or `in_base([0, 1])`.
  # @return [self]
  def in_binary
    in_base(2)
  end

  # Just an alias to `to_base(2)`.
  # @see Number#to_base
  # @return [String]
  def to_binary
    to_base(2)
  end

  # Just an alias to `to_base(Bases::HEX)`.
  # @see Numer#to_base
  # @return [String]
  def to_hex
    to_base(16)
  end

  private

  def native_ruby_base?(base)
    base.is_a?(Fixnum) && base.between?(2, 36)
  end

  # A facility method for accessing the `Algorithms` module.
  def algorithms
    Bases::Algorithms
  end

  # A facility method for accessing the `Helpers` module.
  def helpers
    Bases::Helpers
  end
end
