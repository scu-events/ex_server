defmodule ExServer.Public.Event do
  use Ecto.Schema
  import Ecto.Changeset


  schema "events" do
    field :description, :string
    field :end_date_time, :naive_datetime
    field :start_date_time, :naive_datetime
    field :summary, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:title, :summary, :description, :start_date_time, :end_date_time])
    |> validate_required([:title, :summary, :description, :start_date_time, :end_date_time])
  end
end
