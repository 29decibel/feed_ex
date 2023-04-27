defmodule FeedEx do
  defmodule Native do
    @moduledoc false
    use Rustler, otp_app: :feed_ex, crate: "feedexnative"
    # When your NIF is loaded, it will override this function.
    def parse_rss(_a), do: :erlang.nif_error(:nif_not_loaded)
    def parse_atom(_a), do: :erlang.nif_error(:nif_not_loaded)
  end

  def parse_rss(rss_string) do
    Native.parse_rss(rss_string)
  end

  def parse_atom(atom_string) do
    Native.parse_atom(atom_string)
  end

  def parse_rss_url(url) do
    case HTTPoison.get(url, [], follow_redirect: true) do
      {:ok, %HTTPoison.Response{body: body}} ->
        # parsing

        parse_rss(body)

      _ ->
        {:error, "can not get http response"}
    end
  end

  def parse_atom_url(url) do
    case HTTPoison.get(url, [], follow_redirect: true) do
      {:ok, %HTTPoison.Response{body: body}} ->
        # parsing

        parse_atom(body)

      _ ->
        {:error, "can not get http response"}
    end
  end
end
