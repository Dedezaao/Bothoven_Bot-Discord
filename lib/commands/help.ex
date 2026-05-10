defmodule BeethovenBot.Commands.Help do
  alias Nostrum.Struct.Embed

  def exibir do
    url_da_imagem = "https://imgur.com/a/jh47nDC"

    embed =
      %Embed{}
      |> Embed.put_title("🎼 Guia de Comandos do Maestro Bothoven")
      |> Embed.put_description("Bem-vindo ao acervo digital! Aqui estão as sinfonias que o Maestro aprendeu:")
      |> Embed.put_color(0x9D00FF)
      |> Embed.put_thumbnail(url_da_imagem)

      |> Embed.put_field("🎵 Descoberta", """
      `!musica` - Sugestão aleatória de hit pop.
      `!top País - Gênero` - Ranking dos 5 mais ouvidos.
      """, false)

      |> Embed.put_field("📖 Conhecimento", """
      `!letra Artista - Música` - Busca a letra da canção.
      `!bio Artista` - Biografia e foto do artista.
      `!cantar Artista - Música` - **[API Mista]** Letra + Capa do Álbum.
      """, false)

      |> Embed.put_field("💾 Seu Acervo Local (JSON)", """
      `!favoritar Música` - Guarda no seu arquivo local.
      `!favoritos` - Lista as partituras salvas.
      `!desfavoritar Música` - Remove do arquivo.
      """, false)

      |> Embed.put_field("⚔️ Interação", """
      `!comparar Artista1 x Artista2` - Batalha de ouvintes mensais.
      """, false)

      |> Embed.put_footer("Exibindo a lista completa de comandos. Symphony for your commands.")

    [embed: embed]
  end
end
