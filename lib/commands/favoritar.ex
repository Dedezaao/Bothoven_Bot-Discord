defmodule BeethovenBot.Commands.Favoritar do
  alias BeethovenBot.Store

  def salvar(msg, args) do
    texto = Enum.join(args, " ") |> String.trim()
    nome_usuario = msg.author.username

    if texto == "" do
      "⚠️ Maestro confuso! Use o formato: `!favoritar Nome da Música`"
    else
      Store.salvar_favorito(nome_usuario, texto)

      "💾 A partitura de **#{texto}** foi guardada com sucesso no acervo por _#{nome_usuario}_!"
    end
  end
end
