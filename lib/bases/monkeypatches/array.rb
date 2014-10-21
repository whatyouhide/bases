# encoding: UTF-8

# Some monkeypatches to the `Array` class.
class Array
  # Return a `Bases::Number` instance with the current array as the
  # value and the source base set to `base`.
  # @param (see Bases::Number#in_base)
  # @return [Number]
  # @see Bases::Number#in_base
  def in_base(base)
    Bases.val(self).in_base(base)
  end

  # Return a `Bases::Number` instance with the current array as the
  # value and the source base set to the binary base.
  # @return [Number]
  # @see Bases::Number#in_binary
  def in_binary
    Bases.val(self).in_binary
  end

  # Return a `Bases::Number` instance with the current array as the
  # value and the source base set to the hexadecimale base.
  # @return [Number]
  # @see Bases::Number#in_hex
  def in_hex
    Bases.val(self).in_hex
  end
end
