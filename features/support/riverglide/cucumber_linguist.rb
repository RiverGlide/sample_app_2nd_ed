module RiverGlide
  module CucumberLinguist
    def for_these things
      things.rows_hash
    end
    alias with_these for_these
  end
end
