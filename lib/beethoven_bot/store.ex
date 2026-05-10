defmodule BeethovenBot.Store do
  @file_path "favoritos.json"


  def ler_favoritos do
    case File.read(@file_path) do

      {:ok, conteudo} -> Jason.decode!(conteudo)
      {:error, :enoent} -> []
      {:error, _} -> []
    end
  end

  def salvar_favorito(usuario, musica) do

    favoritos_atuais = ler_favoritos()

    novo_item = %{"usuario" => usuario, "musica" => musica}

    nova_lista = [novo_item | favoritos_atuais]

    File.write!(@file_path, Jason.encode!(nova_lista, pretty: true))
  end

  def remover_favorito(musica_alvo) do
    favoritos_atuais = ler_favoritos()

    nova_lista = Enum.reject(favoritos_atuais, fn item ->
      String.downcase(item["musica"]) == String.downcase(musica_alvo)
    end)

    File.write!(@file_path, Jason.encode!(nova_lista, pretty: true))

    length(favoritos_atuais) != length(nova_lista)
  end

end
