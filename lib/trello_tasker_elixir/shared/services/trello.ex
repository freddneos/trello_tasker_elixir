defmodule TrelloTaskerElixir.Shared.Service.Trello do
  @token Application.get_env(:trello_tasker_elixir, :trello)[:token]
  @key Application.get_env(:trello_tasker_elixir, :trello)[:key]

  def get_card(card_id) do
    {@token, @key}
  end
end
