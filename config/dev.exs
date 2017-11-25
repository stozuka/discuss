use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
# config :discuss, Discuss.Endpoint,
#   http: [port: 4000],
#   debug_errors: true,
#   code_reloader: true,
#   check_origin: false,
#   watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin",
#                     cd: Path.expand("../", __DIR__)]]

config :discuss, Discuss.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [scheme: "https", host: "phoenixdiscuss.herokuapp.com", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/manifest.json",
  secret_key_base: Map.fetch!(System.get_env(), "SECRET_KEY_BASE"),
  check_origin: false

# Watch static and templates for browser reloading.
config :discuss, Discuss.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
# config :discuss, Discuss.Repo,
#   adapter: Ecto.Adapters.Postgres,
#   username: "postgres",
#   password: "postgres",
#   database: "discuss_dev",
#   hostname: "localhost",
#   pool_size: 10

config :discuss, Discuss.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true
