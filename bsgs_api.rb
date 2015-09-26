#!/usr/bin/env ruby

require 'openssl'

class BSGS
  def initialize(a, b, n)
    @a = a.to_i
    @b = b.to_i
    @n = n.to_i
    raise "error" if sanitycheck
  end

  def exploit
    m = findm 

    table = {}
    (0..m-1).each do |j|
      tmp = @a.to_bn.mod_exp(j,@n)
      table["#{tmp}"] = j
    end

    y = @b

    ainv = @a.to_bn.mod_inverse(@n).to_i

    (0..m).each do |i|
      if !table.has_key?(y.to_s)
        y = (y * ainv.to_bn.mod_exp(m,@n).to_i) % @n
      else
        return i*m+table[y.to_s]
      end
    end
    return nil
  end

private 
  def findm
    SqrtInt.sqrt(@n)
  end

  def sanitycheck
    return false if @a.nil? || @b.nil? || @n.nil?
  end
end

class SqrtInt
  #REF http://stackoverflow.com/questions/15529205/ruby-sqrt-on-a-very-large-integer-cause-rounding-issues
  def self.sqrt a
    begv = 1
    endv = a
    while endv > begv + 1
       mid = (endv + begv)/2
       if mid ** 2 <= a
          begv = mid
       else
          endv = mid
       end
    end
    return endv #ceiling sqr root
  end
end

=begin
n=986577959
a=828407
e=1044167
b=a.to_bn.mod_exp(e, n).to_i
bsgs = BSGS.new(a,b,n)
p bsgs.exploit
=end
