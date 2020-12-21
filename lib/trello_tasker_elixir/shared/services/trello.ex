defmodule TrelloTaskerElixir.Shared.Services.Trello do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.trello.com/1/cards"
  plug Tesla.Middleware.Headers, [{"User-Agent", "request"}]
  plug Tesla.Middleware.JSON

  @token Application.get_env(:trello_tasker_elixir, :trello)[:token]
  @key Application.get_env(:trello_tasker_elixir, :trello)[:key]

  def get_card(card_id) do
    {:ok , response} = "#{card_id}?list=true&key=" <> @key <> "&token=" <> @token
    |> get()

    status = response.status

    if status !== 200 do
      {:error , "error on request"}
    else
      body = response.body
      body
      |> IO.inspect
    end
  end
end

#t4BEc9zf
