# Import all plugins from `rel/plugins`
# They can then be used by adding `plugin MyPlugin` to
# either an environment, or release definition, where
# `MyPlugin` is the name of the plugin module.
Path.join(["rel", "plugins", "*.exs"])
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Mix.Releases.Config,
    # This sets the default release built by `mix release`
    default_release: :default,
    # This sets the default environment used by `mix release`
    default_environment: Mix.env()

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/configuration.html


# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"><!KT_@/gvFEU{zL$o.1)(Ex[yq12NBdT7Cbnw0/IRwi!0xK],YH,lo{t@Vq],:%"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :">^8,=V3>Di!x%nZdZ4%(3/8sEZlIt6gCI=85LNHnB;zp@9:cYgDFP/3>y2M>Yod."
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix release`, the first release in the file
# will be used by default

release :backend do
  set version: "0.1.0"
  set applications: [
    :runtime_tools,
    core: :permanent,
    couch_potato_connect: :permanent,
    darko: :permanent,
    geocoder: :permanent,
    huebris: :permanent,
    plex_connect: :permanent,
    sabnzbd_connect: :permanent,
    smart_things_connect: :permanent,
    sonarr_connect: :permanent
  ]
end

