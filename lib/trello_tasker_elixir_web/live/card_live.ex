defmodule TrelloTaskerElixirWeb.CardLive do
  use TrelloTaskerElixirWeb, :live_view

  alias Phoenix.View
  alias TrelloTaskerElixirWeb.CardView
  alias TrelloTaskerElixir.Shared.Services.Trello

  @impl true
  def mount(_params, _session, socket) do
    posts = Trello.get_cards_all("123")

    socket = socket |> assign(posts_list: posts)
    {:ok, assign(socket, query: "", results: %{})}
  end

  @impl true
  def render(assigns) do
    View.render(CardView, "index.html", assigns)
  end
end
