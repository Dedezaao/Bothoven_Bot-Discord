defmodule BeethovenBotTest do
  use ExUnit.Case
  doctest BeethovenBot

  test "greets the world" do
    assert BeethovenBot.hello() == :world
  end
end
