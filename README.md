# OhioElixir

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


## Setting Up and Logging In as an Admin User

To set up an initial admin user and log in through the site:

### Creating an Admin User

1. **Start an IEx Session:**
   - Open a terminal, navigate to your project's root directory, and start an IEx session with Phoenix loaded:
     ```bash
     iex -S mix phx.server
     ```
     Alternatively, for a session without the Phoenix server, use `iex -S mix`.

2. **Create Admin User Attributes:**
   - In the IEx session, define a map with the admin user's attributes. Replace with the desired email and password:
     ```elixir
     admin_attrs = %{email: "admin@example.com", password: "securepassword"}
     ```

3. **Register the Admin User:**
   - Use the `register_user` function to create the admin user:
     ```elixir
     OhioElixir.Accounts.register_user(admin_attrs)
     ```
   - If successful, this will return `{:ok, %User{}}` with the user details.

### Logging In as an Admin

1. **Visit the Login Page:**
   - Open your web browser and go to [`localhost:4000/users/log_in`](http://localhost:4000/users/log_in).

2. **Enter Credentials:**
   - Enter the email and password for the admin user you created in the IEx session.

3. **Access Admin Features:**
   - After logging in, you'll have access to admin features and functionality.

### Why This Process?

- Currently, our site is designed for admin-only usage, hence the lack of a user-facing registration system.
- This manual setup via IEx is necessary for local development and testing, allowing developers to easily set up an admin user and test the full range of site features.

## Using Nix Shell for Development

This project includes a `shell.nix` file, which sets up a Nix shell environment with all the necessary development dependencies. Using a Nix shell ensures that every developer works with the same environment, reducing "works on my machine" issues.

To use the Nix shell:

1. **Ensure Nix is Installed:**
   Make sure you have [Nix installed](https://nixos.org/download.html) on your system.

2. **Enter the Nix Shell:**
   Open a terminal in the project's root directory and run `nix-shell`. This command will create a shell environment as defined in `shell.nix`.

3. **Developing Inside the Nix Shell:**
   Once inside the Nix shell, you can run usual development commands like `mix phx.server`, `mix test`, etc., and they will execute in an environment with all the dependencies specified in `shell.nix`.


## Learn more

  * Official website: [https://www.phoenixframework.org/](https://www.phoenixframework.org/)
  * Guides: [https://hexdocs.pm/phoenix/overview.html](https://hexdocs.pm/phoenix/overview.html)
  * Docs: [https://hexdocs.pm/phoenix](https://hexdocs.pm/phoenix)
  * Forum: [https://elixirforum.com/c/phoenix-forum](https://elixirforum.com/c/phoenix-forum)
  * Source: [https://github.com/phoenixframework/phoenix](https://github.com/phoenixframework/phoenix)

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).