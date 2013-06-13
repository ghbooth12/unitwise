require 'spec_helper'

describe Unitwise::Expression do
  it "should handle basic units" do
    e = Unitwise::Expression.new "[ft_i]"
    e.atom.must_equal '[ft_i]'
    e.prefix.must_be_nil
    e.exponent.must_equal 1
    e.other_expression.must_be_nil
  end

  it "should handle prefixed units" do
    e = Unitwise::Expression.new "mm"
    e.atom.must_equal "m"
    e.prefix.must_equal "m"
    e.exponent.must_equal 1
    e.other_expression.must_be_nil
  end

  it "should handle units with exponents" do
    e = Unitwise::Expression.new "[in_i]3"
    e.atom.must_equal "[in_i]"
    e.prefix.must_be_nil
    e.exponent.must_equal 3
    e.other_expression.must_be_nil
  end

  it "should handle divided units" do
    es = Unitwise::Expression.new("[mi_i]/h").expressions
    es.map(&:operator).must_equal(['/',nil])
    es.map(&:atom).must_equal(["[mi_i]","h"])
    es.map(&:prefix).must_equal([nil, nil])
    es.map(&:exponent).must_equal([1,-1])
  end

  it "should handle divided units with exponents" do
    es = Unitwise::Expression.new("kN/cm2").expressions
    es.map(&:operator).must_equal ['/',nil]
    es.map(&:atom).must_equal ['N','m']
    es.map(&:prefix).must_equal ['k','c']
    es.map(&:exponent).must_equal [1, -2]
  end
end