defmodule Heyoheyo.Mixfile do
  use Mix.Project

  @target System.get_env("MIX_TARGET") || "host"

  Mix.shell.info([:green, """
  Mix environment
    MIX_TARGET:   #{@target}
    MIX_ENV:      #{Mix.env}
  """, :reset])

  def project do
    [app: :heyoheyo,
     version: "0.1.0",
     elixir: "~> 1.4",
     target: @target,
     archives: [nerves_bootstrap: "~> 0.6"],
     deps_path: "deps/#{@target}",
     build_path: "_build/#{@target}",
     lockfile: "mix.lock.#{@target}",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(@target),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application, do: application(@target)

  def application(_target) do
    [mod: {Heyoheyo.Application, []},
     extra_applications: [:logger, :crypto, :ssl, :inets]]
  end

  #   {:my_dep, "~> 0.3.0"}
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  def deps do
    [{:nerves, "~> 0.7", runtime: false}] ++
    deps(@target)
  end

  # Specify target specific dependencies
  def deps("host"), do: []
  def deps(target) do
    [
      {:bootloader, "~> 0.1"},
      {:nerves_runtime, "~> 0.4"},
      {:nerves_init_gadget, "~> 0.2"}
    ] ++ system(target)
  end

  def system("rpi0"), do: [{:nerves_system_rpi0, ">= 0.0.0", runtime: false}]
  def system(target), do: Mix.raise "Unknown MIX_TARGET: #{target}"

  # We do not invoke the Nerves Env when running on the Host
  def aliases("host"), do: []
  def aliases(_target) do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end

end
