# Performs a Ping to an HTTP endpoint
defmodule Heyoheyo.Worker do
  use GenServer

  defp do_ping() do
    IO.puts("Working!")
    {:ok, _} = :httpc.request(:get, {'https://requestb.in/r5fbicr5', []}, [], [])
  end

  defp schedule_ping do
    IO.puts("Scheduling work")
    Process.send_after(self(), :work, 6_000)
  end

  def handle_info(:work, state) do
    do_ping()
    schedule_ping()
    {:noreply, state}
  end

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(count) do
    schedule_ping()
    {:ok, count}
  end
end
