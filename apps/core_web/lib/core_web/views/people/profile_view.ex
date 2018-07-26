defmodule CoreWeb.ProfileView do
  use CoreWeb, :view

  def render("index.json", %{profiles: profiles}) do
    %{
      links: %{
        self:  "/api/v1/profiles"
      },
      data: render_many(profiles, CoreWeb.ProfileView, "profile.json")
    }
  end

  def render("show.json", %{profile: profile}) do
    %{data: render_one(profile, CoreWeb.ProfileView, "profile.json")}
  end

  def render("profile.json", %{profile: profile}) do
    %{
      links: %{
        self:  "/api/v1/people/profiles/#{profile.id}"
      },
      id: profile.id,
      user_id: profile.user_id,
      username: profile.username
    }

  end
end
