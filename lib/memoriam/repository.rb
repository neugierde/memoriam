# auto_register: false

require "rom-repository"
require "memoriam/container"
require "memoriam/import"

module Memoriam
  class Repository < ROM::Repository::Root
    include Import.args["persistence.rom"]
  end
end
