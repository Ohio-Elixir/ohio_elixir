defmodule OhioElixirWeb.Router do
  use OhioElixirWeb, :router

  import OhioElixirWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :put_root_layout, {OhioElixirWeb.LayoutView, :root}
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers, %{"content-security-policy" => "default-src 'self'"}
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", OhioElixirWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/past_meetings", PastMeetingsController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", OhioElixirWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: OhioElixirWeb.Telemetry
    end
  end

  ## Authentication routes

  scope "/", OhioElixirWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
  end

  scope "/", OhioElixirWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update

    resources "/meetings", MeetingController do
      post "/activate", ActivationController, :create
    end

    resources "/speakers", SpeakerController
  end

  scope "/", OhioElixirWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
  end
end
