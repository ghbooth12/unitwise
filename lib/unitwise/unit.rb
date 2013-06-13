module Unitwise
  class Unit
    include Unitwise::Composable

    def initialize(expression)
      @expression = Expression.new(expression.to_s)
    end

    def expressions
      @expression.expressions
    end

    def terms
      @terms ||= expressions.map do |e|
        Term.new(atom_code: e.atom, prefix_code: e.prefix, exponent: e.exponent)
      end
    end

    def root_terms
      terms.flat_map(&:root_terms)
    end

  end
end