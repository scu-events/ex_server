defmodule ExServerWeb.PageController do
  use ExServerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
