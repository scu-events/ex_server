defmodule ExServer.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :title, :string
      add :summary, :string
      add :description, :string
      add :start_date_time, :naive_datetime
      add :end_date_time, :naive_datetime

      timestamps()
    end

  end
end
