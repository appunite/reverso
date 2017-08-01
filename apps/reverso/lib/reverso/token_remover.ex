defmodule Reverso.TokenRemover do
  use GenServer

  @name __MODULE__
  # server callbacks

  def start_link do
    GenServer.start_link(__MODULE__, [], name: @name)
  end

  def init(list) do
    {:ok, list}
  end

  def handle_call({:read}, _from, list) do
    {:reply, list, list}
  end

  def handle_cast({:add_token, token}, list) do
    schedule_work()
    {:noreply, [token | list]}
  end

  def handle_info(:delete_token, list) do
    token = List.last(list)
    Reverso.Accounts.Password.delete_password_token(token)
    IO.puts("Removing token: " <> token)
    {:noreply, List.delete(list, token)}
  end

  defp schedule_work() do
    Process.send_after(self(), :delete_token, 1 * 60 * 60 * 1000)
  end

  # client API

  def read_token_list() do
    GenServer.call(@name, {:read})
  end

  def add_token(token) do
    GenServer.cast(@name, {:add_token, token})
  end
end
