# Nerves WiFi Beacon

## What is It?

A full blown Linux system onto a [Raspberry Pi 0w](https://twitter.com/search?q=%23rpi0w) using [Nerves](http://nerves-project.org) and [Elixir](https://elixir-lang.org).

Once installed, it will ping [this site right here](https://requestb.in/r5fbicr5?inspect) every 6 seconds, letting you know everything is OK.

## Up and Running

 0. Change `"WIFI NETWORK NAME"` and `"WIFI PASSWORD"` in `config/config.exs`.
 1. `env MIX_TARGET=rpi0 mix deps.get`
 2. `env MIX_TARGET=rpi0 mix firmware`
 3. Plug a fresh Micro SD into your laptop.
 4. `env MIX_TARGET=rpi0 mix firmware.burn`
 5. Plug the SD card into your Pi.
 6. Boot up. Watch it amaze.
