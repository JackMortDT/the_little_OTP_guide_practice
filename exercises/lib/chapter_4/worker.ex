defmodule Chapter4.Worker do
  use GenServer

  @name CW

  ## Client API

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts ++ [name: CW])
  end

  def write(key, value) do
    GenServer.call(@name, {:write, key, value})
  end

  def read(key) do
    GenServer.call(@name, {:read, key})
  end

  def delete(key) do
    GenServer.call(@name, {:delete, key})
  end

  def exists(key) do
    GenServer.call(@name, {:exists, key})
  end

  def clear do
    GenServer.cast(@name, :clear)
  end

  ## Server Callbacks

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:write, key, value}, _from, stats) do
    map = update_stats(stats, key, value)
    {:reply, %{key: value}, map}
  end

  def handle_call({:read, key}, _from, stats) do
    {:reply, read_stats(stats, key), stats}
  end

  def handle_call({:delete, key}, _from, stats) do
    {:reply, :deleted, delete_key(stats, key)}
  end

  def handle_call({:exists, key}, _from, stats) do
    {:reply, key_exists(stats, key), stats}
  end

  def handle_cast(:clear, _stats) do
    {:noreply, %{}}
  end

  ## Helpers Functions

  defp update_stats(old_stats, key, value) do
    case Map.has_key?(old_stats, key) do
      true ->
        Map.update!(old_stats, key, &(&1 = value))
      false ->
        Map.put(old_stats, key, value)
    end
  end

  defp read_stats(stats, key) do
    case Map.has_key?(stats, key) do
      true ->
        Map.get(stats, key)
      false ->
        :not_found
    end
  end

  defp delete_key(stats, key), do: Map.delete(stats, key)

  defp key_exists(stats, key), do: Map.has_key?(stats, key)
end
