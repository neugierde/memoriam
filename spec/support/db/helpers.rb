module Test
  module DatabaseHelpers
    module_function

    def rom
      Memoriam::Container["persistence.rom"]
    end

    def db
      Memoriam::Container["persistence.db"]
    end
  end
end
