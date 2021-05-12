defmodule Counter do
  def start(initial_count) do #server: using process primitives to track processes
    spawn( fn() -> Counter.Server.run(initial_count) end ) #Lifecycle: can't recover from crash
  end

  def tick(pid) do #client: concurrencey
    send pid, {:tick, self()}
  end

  def state(pid) do #client: concurrencey
    send pid, {:state, self()}
    receive do
      {:count, value} -> value
    end
  end
end
