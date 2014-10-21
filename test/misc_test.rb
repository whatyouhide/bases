# encoding: UTF-8

require_relative 'test_helper'

class MiscTest < Minitest::Test
  def test_some_basic_bases_are_defined
    assert_const_defined :B62
    assert_const_defined :B64
  end

  def test_val
    assert_respond_to mod, :val
    assert_instance_of mod::Number, mod.val(33)
  end

  def test_brackets
    assert_respond_to mod, :[]
    assert_instance_of mod::Number, mod[0xba]
    assert_equal 044, mod['44'].in_base(8).to_i
  end

  private

  def assert_const_defined(const)
    assert mod.const_defined?(const),
      "#{const} is not defined in module #mod"
  end

  def mod
    Bases
  end
end
