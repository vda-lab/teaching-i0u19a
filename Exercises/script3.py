#!/usr/bin/env python

def loopExp(x,n):
  tmp = 1
  for i in range(0,n):
    tmp = tmp * x
  return tmp

print("Running loopExp(5,3):")
print(loopExp(5,3))
