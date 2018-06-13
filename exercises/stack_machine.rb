require 'pry'

module Validable
  def integer?(input)
    Integer(input) rescue false
  end

end

class Minilang
  include Validable

  TOKENS_NEEDING_STACK = ['ADD', 'SUB', 'MULT', 'DIV', 'MOD', 'POP']
  TOKENS = ['PUSH', 'PRINT'] + TOKENS_NEEDING_STACK

  attr_accessor :register, :stack
  attr_reader :operations

  def initialize(string)
    @operations = string.split
    @register = 0
    @stack = []
  end

  def eval
    raise ArgumentError.new("Invalid token: #{invalid_tokens}") unless valid_tokens?
    raise ArgumentError.new("Nothing to print") if no_print?
    operations.each do |op|
      next self.register = op.to_i if integer?(op)
      raise ArgumentError.new("Nothing in the stack") if needs_stack?(op)
      choose_operation(op)
    end
    puts ""
  end

  private

  def no_print?
    operations.none? { |op| op == 'PRINT' }
  end

  def valid_tokens?
    operations.all? { |op| TOKENS.include?(op) || integer?(op) }
  end

  def invalid_tokens
    operations.reject { |op| TOKENS.include?(op) || integer?(op) }.join(', ')
  end

  def needs_stack?(op)
    stack.empty? && TOKENS_NEEDING_STACK.include?(op)
  end

  def choose_operation(keyword)
    case keyword
    when 'PUSH'   then push_to_stack
    when 'ADD'    then add
    when 'SUB'    then substr
    when 'MULT'   then mult
    when 'DIV'    then div
    when 'MOD'    then mod
    when 'POP'    then pop
    when 'PRINT'  then puts register
    end
  end


  def push_to_stack
    stack << register
  end

  def add
    self.register += stack.pop
  end

  def substr
    self.register -= stack.pop
  end

  def mult
    self.register *= stack.pop
  end

  def div
    self.register /= stack.pop
  end

  def mod
    self.register = register.remainder(stack.pop)
  end

  def pop
    self.register = stack.pop
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

# Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

# Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)
