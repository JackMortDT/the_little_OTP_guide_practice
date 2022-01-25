defmodule Chapter3.PingPong do
  def example_1 do
    receive do
      {:ping} ->
        IO.puts("pong")

      {:pong} ->
        IO.puts("ping")
    end
  end

  def example_2 do
    receive do
      {:ping, pid} ->
        IO.puts(":pong!")
        :timer.sleep(500)
        send(pid, {:pong, pid})
        example_2()

      {:pong, pid} ->
        IO.puts(":ping!")
        :timer.sleep(500)
        send(pid, {:ping, pid})
        example_2()
    end
  end

  def example_3 do
    IO.puts(inspect self())
    receive do
      {:ping, process1, process2} ->
        :timer.sleep(1_000)
        IO.puts(":pong!")
        send(process2, {:pong, process1, process2})
        example_3()

      {:pong, process1, process2} ->
        :timer.sleep(1_000)
        IO.puts(":ping!")
        send(process1, {:ping, process1, process2})
        example_3()
    end
  end
end
