# encoding: UTF-8

# Some monkeypatches to the `Integer` class.
class Integer
  # Convert this number to a given `base`.
  # @param (see Bases::Number#to_base)
  # @return [String]
  # @see Bases::Number#to_base
  def to_base(base, opts = {})
    Bases.val(self).to_base(base, opts)
  end

  # Convert this number in binary form.
  # @return [String]
  # @see Bases::Number#to_binary
  def to_binary
    to_base(2)
  end

  # Convert this number in hexadecimal form.
  # @return [String]
  # @see Bases::Number#to_hex
  def to_hex
    to_base(16)
  end
end
