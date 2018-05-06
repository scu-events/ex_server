defmodule ExServer.PublicTest do
  use ExServer.DataCase

  alias ExServer.Public

  describe "events" do
    alias ExServer.Public.Event

    @valid_attrs %{description: "some description", end_date_time: ~N[2010-04-17 14:00:00.000000], start_date_time: ~N[2010-04-17 14:00:00.000000], summary: "some summary", title: "some title"}
    @update_attrs %{description: "some updated description", end_date_time: ~N[2011-05-18 15:01:01.000000], start_date_time: ~N[2011-05-18 15:01:01.000000], summary: "some updated summary", title: "some updated title"}
    @invalid_attrs %{description: nil, end_date_time: nil, start_date_time: nil, summary: nil, title: nil}

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Public.create_event()

      event
    end

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Public.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Public.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = Public.create_event(@valid_attrs)
      assert event.description == "some description"
      assert event.end_date_time == ~N[2010-04-17 14:00:00.000000]
      assert event.start_date_time == ~N[2010-04-17 14:00:00.000000]
      assert event.summary == "some summary"
      assert event.title == "some title"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Public.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, event} = Public.update_event(event, @update_attrs)
      assert %Event{} = event
      assert event.description == "some updated description"
      assert event.end_date_time == ~N[2011-05-18 15:01:01.000000]
      assert event.start_date_time == ~N[2011-05-18 15:01:01.000000]
      assert event.summary == "some updated summary"
      assert event.title == "some updated title"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Public.update_event(event, @invalid_attrs)
      assert event == Public.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Public.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Public.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Public.change_event(event)
    end
  end
end
