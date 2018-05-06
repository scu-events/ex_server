defmodule ExServerWeb.EventControllerTest do
  use ExServerWeb.ConnCase

  alias ExServer.Public
  alias ExServer.Public.Event

  @create_attrs %{description: "some description", end_date_time: ~N[2010-04-17 14:00:00.000000], start_date_time: ~N[2010-04-17 14:00:00.000000], summary: "some summary", title: "some title"}
  @update_attrs %{description: "some updated description", end_date_time: ~N[2011-05-18 15:01:01.000000], start_date_time: ~N[2011-05-18 15:01:01.000000], summary: "some updated summary", title: "some updated title"}
  @invalid_attrs %{description: nil, end_date_time: nil, start_date_time: nil, summary: nil, title: nil}

  def fixture(:event) do
    {:ok, event} = Public.create_event(@create_attrs)
    event
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all events", %{conn: conn} do
      conn = get conn, event_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create event" do
    test "renders event when data is valid", %{conn: conn} do
      conn = post conn, event_path(conn, :create), event: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, event_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some description",
        "end_date_time" => ~N[2010-04-17 14:00:00.000000],
        "start_date_time" => ~N[2010-04-17 14:00:00.000000],
        "summary" => "some summary",
        "title" => "some title"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, event_path(conn, :create), event: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update event" do
    setup [:create_event]

    test "renders event when data is valid", %{conn: conn, event: %Event{id: id} = event} do
      conn = put conn, event_path(conn, :update, event), event: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, event_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some updated description",
        "end_date_time" => ~N[2011-05-18 15:01:01.000000],
        "start_date_time" => ~N[2011-05-18 15:01:01.000000],
        "summary" => "some updated summary",
        "title" => "some updated title"}
    end

    test "renders errors when data is invalid", %{conn: conn, event: event} do
      conn = put conn, event_path(conn, :update, event), event: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete event" do
    setup [:create_event]

    test "deletes chosen event", %{conn: conn, event: event} do
      conn = delete conn, event_path(conn, :delete, event)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, event_path(conn, :show, event)
      end
    end
  end

  defp create_event(_) do
    event = fixture(:event)
    {:ok, event: event}
  end
end
