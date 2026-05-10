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
      ["!musica"] -> Message.create(msg.channel_id, Commands.Musica.musica_aleatoria())

      ["!letra" | resto] -> Message.create(msg.channel_id, Commands.Letra.buscar_letra(resto))

      ["!bio" | artista] -> Message.create(msg.channel_id, Commands.Bio.buscar(artista))

      ["!comparar" | args] -> Message.create(msg.channel_id, Commands.Comparar.batalha(args))

      ["!top" | args] -> Message.create(msg.channel_id, Commands.Top.buscar(args))

      ["!favoritar" | args] -> Message.create(msg.channel_id, Commands.Favoritar.salvar(msg, args))
      ["!favoritos"] -> Message.create(msg.channel_id, Commands.Favoritos.listar())
      ["!desfavoritar" | args] -> Message.create(msg.channel_id, Commands.Desfavoritar.remover(args))

      ["!cantar" | args] -> Message.create(msg.channel_id, Commands.Cantar.executar(args))

      ["!help"] -> Message.create(msg.channel_id, Commands.Help.exibir())
      ["!ajuda"] -> Message.create(msg.channel_id, Commands.Help.exibir())
      _ -> :ignore
    end

  end

end
