# Baby-Step Gaint-Step algorithm
An algorithm to find dislogrithm problem in O(sqrt(n))

[REF](https://en.wikipedia.org/wiki/Baby-step_giant-step)  

**NOTICE**  
The algorithm consume lots of memory.  
It seems out written in ruby is not efficiency enough.  
I am working out to find some lib in C such as PARI/GP to seed this up!

**How to use**
```ruby
  #sovling a^x = b (mod n)
  bsgs = BSGS.new(a,b,n)
  p bsgs.exploit #print out x
```
