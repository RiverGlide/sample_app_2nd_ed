module RiverGlide
  class Assistant
    def remember_the relevant, information
      @notepad ||= {}
      @notepad[relevant] = information
    end

    def recall_the memory
      @notepad[memory]
    end
  end
end
