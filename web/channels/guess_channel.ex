defmodule TimerSocket.GuessChannel do
  use Phoenix.Channel

  def join("guess:guess", _msg, socket) do
    {:ok, socket}
  end

  def handle_in("guess-number", msg, socket) do
    push socket, "guess-number", msg
    {:noreply, socket}
  end

  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

end