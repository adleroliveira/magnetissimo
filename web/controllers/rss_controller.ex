defmodule Magnetissimo.RssController do
  use Magnetissimo.Web, :controller
  alias Magnetissimo.Torrent

  def index(conn, %{"term" => term}) do
    query = from t in Torrent,
            where: ilike(t.name, ^"%#{term}%"),
            order_by: [desc: :inserted_at],
            limit: 100
    torrents = Repo.all(query)
    conn
    |> put_resp_content_type("text/xml")
    |> render("index.xml", torrents: torrents)
  end

  def index(conn, _params) do
    query = from t in Torrent,
            order_by: [desc: :inserted_at],
            limit: 100
    torrents = Repo.all(query)
    conn
    |> put_resp_content_type("text/xml")
    |> render("index.xml", torrents: torrents)
  end
end
