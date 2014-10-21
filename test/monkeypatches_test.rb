# encoding: UTF-8

require_relative 'test_helper'
require_relative '../lib/bases/monkeypatches'

module MonkeypatchesTests
  class IntegerTest < Minitest::Test
    def test_to_base
      assert_equal '10', 10.to_base(10)
      assert_equal '10', 0b1010.to_base(10)
      assert_equal 'A', 0xa.to_base(16).upcase

      assert_equal %w(1 0), 2.to_base(2, array: true)
    end

    def test_common_methods
      assert_equal '1010', 10.to_binary
      assert_equal 'A', 10.to_hex.upcase
    end
  end

  class StringTest < Minitest::Test
    def test_in_base
      assert_equal '2', '10'.in_base(2).to_hex
      assert_equal '1010', 'A'.in_base(16).to_base(2)
      assert_equal '1010', 'baba'.in_base([:a, :b]).to_base(2)
    end

    def test_common_methods
      assert_equal 2, '10'.in_binary.to_i
      assert_equal 2, 'bar foo'.in_base(%w(foo bar)).to_i
      assert_equal 10, 'a'.in_hex.to_i
    end
  end

  class ArrayTest < Minitest::Test
    def test_in_base
      assert_equal 11, [1, 0, 1, 1].in_base(2).to_i
    end

    def test_common_methods
      assert_equal 2, [1, 0].in_binary.to_i
      assert_equal 171, ['a', 'b'].in_hex.to_i
    end
  end
end
