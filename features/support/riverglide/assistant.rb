module RiverGlide
  class Assistant
    def initialize
      @notepad = {}
    end

    def remember_the relevant, information
      @notepad[relevant] = information
    end

    def recall_the memory
      @notepad[memory] or raise NoRecollectionComplaint
    end
  end

  class Assistant::NoRecollectionComplaint < RuntimeError
  end
end
