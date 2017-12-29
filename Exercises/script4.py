#!/usr/bin/env python

def exp(x,n):
  if n == 0:
    return 1
  else:
    return x * exp(x, n-1)

print("Running exp(5,3):")
print(exp(5,3))
