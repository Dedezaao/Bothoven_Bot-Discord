defmodule BeethovenBot.Commands.Help do
  alias Nostrum.Struct.Embed

  @icon_url "https://i.imgur.com/IAgaymE.png"

  def exibir do
    embed =
      %Embed{}
      |> Embed.put_title("🎼 Guia Completo do Maestro Bothoven")
      |> Embed.put_description("A orquestra completa! Aqui estão todas as sinfonias e ferramentas disponíveis no meu acervo:")
      |> Embed.put_color(0x9D00FF)
      |> Embed.put_thumbnail(@icon_url)

      |> Embed.put_field("🎵 Hits e Descobertas", """
      `!musica` - Sugere um hit pop aleatório (iTunes).
      `!hit <Artista>` - O maior sucesso do artista no momento (Deezer).
      `!top <País> - <Gênero>` - Ranking das 5 mais ouvidas (iTunes).
      """, false)

      |> Embed.put_field("🎤 Letras e Karaokê", """
      `!letra <Art> - <Mus>` - Busca apenas a letra da música (Lyrics.ovh).
      `!cantar <Art> - <Mus>` - Traz a letra, capa do álbum e áudio (Mista).
      """, false)

      |> Embed.put_field("📖 Enciclopédia Musical", """
      `!bio <Artista>` - Biografia completa do artista (Wikipedia).
      `!comparar <Art1> x <Art2>` - Batalha de ouvintes (Last.fm).
      """, false)

      |> Embed.put_field("💾 Acervo Local (JSON)", """
      `!favoritar <Música>` - Salva uma música na sua lista.
      `!favoritos` - Lista todas as partituras salvas.
      `!desfavoritar <Música>` - Remove uma música da lista.
      """, false)

      |> Embed.put_field("🔮 Extras", """
      `!filosofia` - Tradução de citações e reflexões (Kanye + MyMemory).
      `!help` ou `!ajuda` - Exibe este menu.
      """, false)

      |> Embed.put_footer("Symphony for your commands • AV2 Programação Funcional")

    [embed: embed]
  end
end
