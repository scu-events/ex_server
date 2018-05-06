defmodule ExServerWeb.EventView do
  use ExServerWeb, :view
  alias ExServerWeb.EventView

  def render("index.json", %{events: events}) do
    %{data: render_many(events, EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{id: event.id,
      title: event.title,
      summary: event.summary,
      description: event.description,
      start_date_time: event.start_date_time,
      end_date_time: event.end_date_time}
  end
end
