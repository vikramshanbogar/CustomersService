# CustomersService


A simple spring boot application to run on local/container consisting of latest spring and java concepts up-to-date.

- [x] Constructor Chaining - Customer.java
  - Constructor call must be the first statement: In Java, a call to another constructor (using this()) or a call to a superclass constructor (using super()) must be the first statement in the constructor.
  - Recursion not permitted: Recursive constructor invocation is not allowed. In simpler terms, a constructor cannot directly or indirectly call itself, as this would lead to an infinite loop and eventually a StackOverflowError.
  - Only one call is allowed: A constructor can call at most one other constructor. It can either call another constructor in the same class (with this()) or it can call a constructor in the superclass (with super()), but it cannot do both.
- [] Adding date columns in entities