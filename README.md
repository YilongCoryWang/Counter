# Counter
Follow Chapter 1 of *Designing Elixir Systems with OTP* which illustrates how to design Elixir systems with 6 layers, and what OTP is with this Counter project.  
  
## Six Layers
Taking advantage of divide-and-conquer strategy, we can divide a project into 6 logical layers which helps us to deal with a smaller piece of complexity each time. It also helps to make projects more maintainable. The layers are data structures, functional core, boundaries, workers, tests and lifecycle. Not all layers are necessary to every project, especially for simple ones like this Counter.  
  
### Data Structure
Database tables and schemas. This project Counter is too simple to have it, or we can call integer variable *value* in Counter.Core.inc/1 as data structure in our project.  
  
### Functional Core
Functions that implements business logic which has no states or side effects, like Counter.Core.inc/1.
  
### Boundaries
Dealing with side effects, state, processes, message passing, and present APIs to the outside world, like Module Counter in this project.  
  
### Lifecycle
Starting, shutting down processes cleanly, handling failures.
  
### Tests
./test
  
### Workers
Different processes in component. Our counter has a single worker, one we use to encapsulate state with OTP.  
  
## OTP
The definition of OTP has evolved from its original *Open Telephone Platform* to a software design pattern which using recursive loop and process primitives to manage process messages and states. The Counter.Server.run/1 is a good example of how recursive loop is used for getting new states. Counter.state/1 and Counter.Server.listen/1 demonstrate how to make this process continue by sending and receiving process messages.  
  
The structure of OTP is like this because variables in functional language are immutable. So every time the state is updated, instead of changing the state variable's value, we call the function itself with the updated variable as parameter (recursion). That explains why Genserver use parameter as states. Genserver is a good example of OTP.  
  
## Usage
```elixir
% iex -S mix
iex(1)>​ counter_pid = Counter.start(0)
#PID<0.112.0>
​iex(2)>​ Counter.tick(counter_pid)
{:tick, #PID<0.112.0>}
​iex(3)>​ Counter.state(counter_pid)
1
​iex(4)>​ Counter.tick(counter_pid)
{:tick, #PID<0.112.0>}
​iex(5)>​ Counter.tick(counter_pid)
{:tick, #PID<0.112.0>}
​iex(6)>​ Counter.state(counter_pid)
3
```
