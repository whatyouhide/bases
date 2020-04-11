# encoding: UTF-8

require_relative 'test_helper'
require 'digest'

class NumberTest < Minitest::Test
  BASE64 = Bases::B64

  NUMBERS_FROM_BASE10 = [
    { base10: 0,  base: 2,       value: '0' },
    { base10: 1,  base: 2,       value: '1' },
    { base10: 2,  base: 2,  value: '10' },
    { base10: 4,  base: 2,  value: '100' },
    { base10: 9,  base: 2,  value: '1001' },
    { base10: 0,  base: 16,     value: '0' },
    { base10: 15, base: 16,     value: 'f' },
    { base10: 16, base: 16,     value: '10' },
    { base10: 3,  base: 3,       value: '10' },
    { base10: 0,  base: %w(≈ y), value: '≈' },
    { base10: 8,  base: %w(≈ +), value: '+≈≈≈' },
    { base10: 63, base: BASE64,  value: '/' }
  ]

  def test_from_base10_integer_to_any_base
    NUMBERS_FROM_BASE10.each do |num_data|
      result = n(num_data[:base10]).to_base(num_data[:base])
      assert_equal num_data[:value], result
    end
  end

  def test_from_any_base_to_base10
    NUMBERS_FROM_BASE10.each do |num_data|
      result = n(num_data[:value]).in_base(num_data[:base]).to_i
      assert_equal num_data[:base10], result
    end
  end

  def test_easy_to_see_numbers_and_identities
    assert_equal 'fade', n(0xfade).to_base(16).downcase
    assert_equal '71', n(071).to_base(8)
    assert_equal '1010110', n(0b1010110).to_base(2)

    assert_equal '10', n('10').in_base(2).to_base(2)
    assert_equal 10, n(10).to_i

    val = 'fwrfwasgefrfqf1r3f43131'
    assert_equal val, n(val).in_base(BASE64).to_base(BASE64)
  end

  def test_facility_methods
    assert_equal 10, n('a').in_hex.to_base(10).to_i
    assert_equal 10, n('1010').in_binary.to_base(10).to_i
    assert_equal '1010', n(10).to_binary
    assert_equal 'A', n(10).to_hex.upcase
  end

  def test_multichar_digits
    assert_equal 2, n(%w(bar foo)).in_base(%w(foo bar)).to_i
    assert_equal 1, n('hello world').in_base(%w(hello world)).to_i
  end

  def test_duplicate_digits_are_checked
    ex = Bases::DuplicateDigitsError
    assert_raises(ex) { n(2).to_base([0, 1, 0]) }
    assert_raises(ex) { n('foo bar').in_base(%w(foo foo)) }
  end

  def test_initial_value_type_is_checked
    ex = Bases::InvalidValueError

    assert_raises(ex) { n({}) }
    assert_raises(ex) { n(nil) }
    assert_raises(ex) { n(0..10) }
    assert_raises(ex) { n(Object.new) }
  end

  def test_digits_are_checked_for_belonging_to_the_base
    ex = Bases::WrongDigitsError
    assert_raises(ex) { n('foo bar baz').in_base(%w(foo bar)) }
  end

  def test_an_exception_is_thrown_if_no_base_is_specified
    ex = Bases::NoBaseSpecifiedError
    assert_raises(ex) { n('10').to_base(10) }
    assert_raises(ex) { n('A').to_i }
    assert_raises(ex) { n(%w(foo bar)).to_base(3) }
    assert_raises(ex) { n([0, 2]).to_i }
  end

  def test_leading_zeros_are_harmless
    assert_equal 2, n('00000010').in_base(2).to_i
    assert_equal 10, n('0a').in_hex.to_i
    assert_equal 1, n(%w(foo bar)).in_base(%w(foo bar)).to_i
  end

  def test_to_i
    assert_equal 10, n('A').in_base(16).to_i
    assert_equal 10, n('a').in_base(16).to_i
    assert_equal 10, n('1010').in_base(2).to_i
  end

  def test_edge_cases
    assert_equal 0, n([]).in_base(2).to_i
    assert_equal 0, n('').in_base(10).to_i
  end

  def test_to_base_outputting_an_array
    assert_equal %w(b a b a), n(10).to_base([:a, :b], array: true)
    assert_equal %w(1 0), n(2).to_base(2, array: true)
  end

  def test_emojis_are_fun_and_💙
    assert_equal '💙💚', n(2).to_base(['💚', '💙'])
  end

  def test_separator
    assert_equal '1~0', n(62).to_base(62, separator: '~')
  end

  private

  def n(val)
    Bases::Number.new(val)
  end
end
