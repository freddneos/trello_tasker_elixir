defmodule TrelloTaskerElixirWeb.CardInfoLive do
  use TrelloTaskerElixirWeb, :live_view

  alias Phoenix.View
  alias TrelloTaskerElixirWeb.CardView
  alias TrelloTaskerElixir.Shared.Services.Trello

  @impl true
  def mount(_params, _session, socket) do
    post = Trello.get_card(_params["id"]) |> IO.inspect()
    socket = socket |> assign(post: post)
    {:ok, assign(socket, query: "", results: %{})}
  end

  @impl true
  def render(assigns) do
    View.render(CardView, "info.html", assigns)
  end
end
