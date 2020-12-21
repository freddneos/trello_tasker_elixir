defmodule TrelloTaskerElixirWeb.CardInfoLive do
  use TrelloTaskerElixirWeb, :live_view

  alias Phoenix.View
  alias TrelloTaskerElixirWeb.CardView

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: "", results: %{})}
  end

  @impl true
  def render(assigns) do
    View.render(CardView, "info.html", assigns)
  end
end