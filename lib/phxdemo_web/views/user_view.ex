defmodule PhxdemoWeb.UserView do
  use PhxdemoWeb, :view
  alias PhxdemoWeb.UserView

  def render("index.json", %{users: users}) do
    render_many(users, UserView, "user.json")
  end

  def render("show.json", %{user: user}) do
    render_one(user, UserView, "user.json")
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      age: user.age
    }
  end
end
