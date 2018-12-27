defmodule TimerSocket.Timer do
  @moduledoc """
  """
  use GenServer
  require Logger

  @doc """
  """
  def start_link() do
    GenServer.start_link(__MODULE__, %{})
  end

  #SERVER
  def init(_state) do
    Logger.warn "Timer was started"
    TimerSocket.Endpoint.subscribe "timer:start", []
    {:ok, nil}
  end

  def handle_info(%{event: "start_timer"}, _time) do
    duration = 30
    schedule_timer 1_000
    broadcast duration, "The timer was started"
    {:noreply, duration}
  end

  def handle_info(:update, 0) do
    broadcast 0, "Time out"
    {:noreply, 0}
  end

  def handle_info(:update, time) do
    leftover = time-1
    broadcast leftover, "Tik-tak"
    broadcast_guess "Осталось #{time}"
    schedule_timer(1_000)
    {:noreply, leftover}
  end

  defp schedule_timer(interval) do
    Process.send_after( self(), :update, interval)
  end

  @doc """
    Вещание для new_time
  """
  defp broadcast(time, response) do
    TimerSocket.Endpoint.broadcast! "timer:update", "new_time", %{
    response: response,
    time: time
    }
  end

  @doc """
    Вещание для guess-number
  """
  defp broadcast_guess(response) do
    TimerSocket.Endpoint.broadcast! "guess:guess", "guess-number", %{
      response: response
    }
  end

end
