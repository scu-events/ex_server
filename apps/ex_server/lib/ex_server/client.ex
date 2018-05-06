defmodule ExServer.Client do
  alias HTTPoison.{Response}

  @url "https://www.googleapis.com/calendar/v3/calendars/santaclara.acm@gmail.com/events?key=AIzaSyCnRyFyPuJ9WSeu602Q7CE13TsxWVNbw10&timeMin=2018-02-24T00:00:00Z&timeMax=2030-04-09T00:00:00Z&singmaxResults=9999&_=1520708172234"

  def get_events! do
    with {:ok, %Response{body: body}} <- HTTPoison.get(URI.encode(@url)),
          %{"items" => events} <- Poison.decode!(body) do
      events
        |> Enum.map(fn event ->
          event |> from_wild |> ExServer.Public.create_event
        end)
    end
  end

  def from_wild(%{"summary" => summary} = event),
    do: from_wild(event |> Map.delete("title"), %{title: summary, summary: summary, description: summary, start_date_time: nil, end_date_time: nil})
  def from_wild(%{"start" => %{"dateTime" => start_time}} = event, acc) do
    {:ok, start_date_time, _} = DateTime.from_iso8601(start_time)
    from_wild(event |> Map.delete("start"), %{acc | start_date_time: start_date_time})
  end
  def from_wild(%{"end" => %{"dateTime" => end_time}} = event, acc) do
    {:ok, end_date_time, _} = DateTime.from_iso8601(end_time)
    from_wild(event |> Map.delete("end"), %{acc | end_date_time: end_date_time})
  end
  def from_wild(_, acc),
    do: acc
end
