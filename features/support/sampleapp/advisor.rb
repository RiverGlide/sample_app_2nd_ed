module SampleApp
  class Advisor

    def initialize from_advisories
      @from_advisories = from_advisories
    end

    def list_of problems
      problems.split ', '
    end

    def number_of problems
      list_of(problems).size
    end

    def advice_for problems
      advisories = list_of(problems).inject([]) do |advice, for_the_problem| 
        advice << @from_advisories.fetch(for_the_problem)
      end
      advisories.join(" ")
    end
  end
end
