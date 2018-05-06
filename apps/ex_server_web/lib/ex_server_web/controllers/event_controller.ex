defmodule ExServerWeb.EventController do
  use ExServerWeb, :controller

  alias ExServer.Public
  alias ExServer.Public.Event

  action_fallback ExServerWeb.FallbackController

  def index(conn, %{"year" => year, "month" => month}) do
    events = Public.list_events(year, month)
    render(conn, "index.json", events: events)
  end
  def index(conn, _params) do
    events = Public.list_events()
    render(conn, "index.json", events: events)
  end

  def create(conn, %{"event" => event_params}) do
    with {:ok, %Event{} = event} <- Public.create_event(event_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", event_path(conn, :show, event))
      |> render("show.json", event: event)
    end
  end

  def show(conn, %{"id" => id}) do
    event = Public.get_event!(id)
    render(conn, "show.json", event: event)
  end

  def update(conn, %{"id" => id, "event" => event_params}) do
    event = Public.get_event!(id)

    with {:ok, %Event{} = event} <- Public.update_event(event, event_params) do
      render(conn, "show.json", event: event)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = Public.get_event!(id)
    with {:ok, %Event{}} <- Public.delete_event(event) do
      send_resp(conn, :no_content, "")
    end
  end
end
