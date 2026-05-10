defmodule BeethovenBot.Commands.Desfavoritar do
  alias BeethovenBot.Store

  def remover(args) do
    musica = Enum.join(args, " ") |> String.trim()

    if musica == "" do
      "⚠️ Maestro confuso! Digite: `!desfavoritar Nome da Música`"
    else
      if Store.remover_favorito(musica) do
        "🗑️ A partitura de **#{musica}** foi jogada no lixo pelo Maestro!"
      else
        "🎼 Não achei **#{musica}** no acervo para remover. Tem certeza do nome?"
      end
    end
  end
end
