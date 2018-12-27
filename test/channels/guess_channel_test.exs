defmodule TimerSocket.GuessChannelTest do
  use TimerSocket.ChannelCase
  alias TimerSocket.GuessChannel

  setup do
    {:ok, _, socket} =
      socket("user_id", %{some: :assign})
      |> subscribe_and_join(GuessChannel, "guess:guess")

    {:ok, socket: socket}
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push socket, "ping", %{"hello" => "Michael"}
    assert_reply ref, :ok, %{"hello" => "Michael"}
  end

  test "broadcasts msg", %{socket: socket} do
    broadcast_from socket, "guess:guess", %{"msg" => "My message"}
    assert_push "guess:guess", %{"msg" => "My message"}
  end

end