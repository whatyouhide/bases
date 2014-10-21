# encoding: UTF-8

require_relative 'test_helper'

class HelpersTest < Minitest::Test
  def test_are_there_duplicates?
    assert helpers.are_there_duplicates?([0, 1, 0])
    assert helpers.are_there_duplicates?([2, 2, 2])
    assert helpers.are_there_duplicates?([nil, nil])
    refute helpers.are_there_duplicates?([])
    refute helpers.are_there_duplicates?([1, '1'])
  end

  def test_base_to_array
    assert_equal %w(0 1), helpers.base_to_array(2)
    assert_equal %w(0 1), helpers.base_to_array([0, 1])
    assert_equal (0...10).map(&:to_s), helpers.base_to_array(10)
    assert_equal %w(foo bar), helpers.base_to_array(%w(foo bar))
  end

  def test_only_valid_digits
    assert helpers.only_valid_digits?(%w(f o o), %(f o))
    assert helpers.only_valid_digits?(%w(f o o), %(foo bar))
    assert helpers.only_valid_digits?(%w(foo bar foo), %(foo bar))
    refute helpers.only_valid_digits?(%w(foo bar baz), %(foo bar))
    refute helpers.only_valid_digits?(%w(012), %(0 1))
  end

  private

  def helpers
    Bases::Helpers
  end
end
