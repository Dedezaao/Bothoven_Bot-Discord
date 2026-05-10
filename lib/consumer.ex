defmodule BeethovenBot.Consumer do

  use Nostrum.Consumer
  alias Nostrum.Api.Message
  alias BeethovenBot.Commands

  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
    if msg.author.bot, do: :ignore, else: processar_comando(msg)
  end

  def handle_event(_), do: :ignore

  defp processar_comando(msg) do

    args = msg.content |> String.trim() |> String.split(" ")

    case args do
      ["!musica"] -> Message.create(msg.channel_id, Commands.musica_aleatoria())
      _ -> :ignore
    end

  end

end
