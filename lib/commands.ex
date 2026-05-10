defmodule BeethovenBot.Commands do

  @doc """
  Implementação de comandos para o Bothoven.
  Focado em funções puras e transformações com Pipe Operator.
  """
  @itunes_api_url "https://itunes.apple.com/search?term=classic&limit=20"

  def musica_aleatoria do
    case HTTPoison.get(@itunes_api_url) do
      {:ok, %{status_code: 200, body: body}} ->
        body
        |> Jason.decode!()
        |> Map.get("results")
        |> Enum.random() # Requisito: Manipulação com Enum [cite: 204]
        |> formatar_musica()

      {:error, _} -> "🎹 Beethoven perdeu a batuta... tente novamente!"
    end
  end

  defp formatar_musica(track) do
    "🎼 **Sugestão do Maestro:** _#{track["trackName"]}_ de **#{track["artistName"]}**"
  end




end
