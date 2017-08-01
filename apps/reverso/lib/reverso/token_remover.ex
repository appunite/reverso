defmodule Reverso.TokenRemover do
  use GenServer


  # server callbacks

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def init(list) do
    {:ok, list}
  end

  def handle_call({:read}, _from, list) do
    {:reply, list, list}
  end

  def handle_cast({:add_token, token}, list) do
    schedule_work()
    {:noreply, list ++ [token]}
  end

  def handle_info(:delete_token, list) do
    IO.puts("Removing token: " <> List.first(list))
    {:noreply, List.delete_at(list, 0)}
  end

  defp schedule_work() do
    Process.send_after(self(), :delete_token, 1 * 1 * 25 * 1000) #for testing only 25s
  end

  # client API

  def read_token_list(pid) do
    GenServer.call(pid, {:read})
  end

  def add_token(pid, token) do
    GenServer.cast(pid, {:add_token, token})
  end
end
