defmodule BeethovenBot.Commands.Prova do
  alias Nostrum.Struct.Embed

  def relatorio do
    embed =
      %Embed{}
      |> Embed.put_title("🎓 Relatório de Avaliação AV2")
      |> Embed.put_description("Olá, professor! O Maestro Bothoven foi construído consumindo **7 APIs REST distintas**, atendendo rigorosamente à tabela de requisitos do projeto:")
      |> Embed.put_color(0x00FF00)

      |> Embed.put_field("1️⃣ Sem Parâmetros (1 Exigido)", """
      `!musica` ➡️ **iTunes API**
      """, false)

      |> Embed.put_field("2️⃣ Com 1 Parâmetro (2 Exigidos)", """
      `!bio <artista>` ➡️ **Wikipedia API**
      `!hit <artista>` ➡️ **Deezer API**
      """, false)

      |> Embed.put_field("3️⃣ Com 2 Parâmetros (2 Exigidos)", """
      `!letra <art> - <mus>` ➡️ **Lyrics.ovh API**
      `!comparar <art1> x <art2>` ➡️ **Last.fm API**
      """, false)

      |> Embed.put_field("4️⃣ Encadeamento de APIs (1 Exigido)", """
      `!filosofia` ➡️ **Kanye.rest API** + **MyMemory API**
      *(O texto retornado pela 1ª API é usado como entrada na 2ª API)*
      """, false)

      |> Embed.put_field("5️⃣ Persistência Local (1 Exigido)", """
      `!favoritar`, `!favoritos`, `!desfavoritar`
      *(Manipulação pura de listas salva em favoritos.json via Jason)*
      """, false)

      |> Embed.put_field("⭐ Comandos Extras (Além da Prova)", """
      `!help` ou `!ajuda` irão mostrar funcionalidades bônus do acervo.
      """, false)

    [embed: embed]
  end
end
