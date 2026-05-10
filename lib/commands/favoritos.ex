defmodule BeethovenBot.Commands.Favoritos do
  alias BeethovenBot.Store
  alias Nostrum.Struct.Embed

  def listar do
    favoritos = Store.ler_favoritos()

    case favoritos do
      [] ->
        "🎼 O acervo está vazio. Que tal começar com `!favoritar Nome da Música`?"

      lista ->
        formatar_lista(lista)
    end
  end

  defp formatar_lista(lista) do
    texto_formatado =
      lista
      |> Enum.take(10)
      |> Enum.map(fn item ->
        "👤 **#{item["usuario"]}** guardou:\n⭐ _#{item["musica"]}_"
      end)
      |> Enum.join("\n\n────────────────\n\n")

    embed =
      %Embed{}
      |> Embed.put_title("🎻 Acervo de Favoritos do Maestro")
      |> Embed.put_description(texto_formatado)
      |> Embed.put_color(0x9D00FF)
      |> Embed.put_footer("Exibindo as últimas 10 partituras salvas")

    [embed: embed]
  end
end
