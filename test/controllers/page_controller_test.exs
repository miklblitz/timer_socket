defmodule TimerSocket.PageControllerTest do
  use TimerSocket.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Socket Chat!"
  end
end
