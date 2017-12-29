#!/usr/bin/env python

a = 1

def add(x):
  global a
  a = a + x
  return a

def multiply_by_two():
  global a
  return a*2

print("Start")
print(a)
print("Multiply a by 2")
print(multiply_by_two())
print("Add 5 to a")
print(add(5))
print("Multiply a by 2")
print(multiply_by_two())
