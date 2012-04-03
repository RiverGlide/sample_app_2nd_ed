module SampleApp
  module Advisor
    def list_of problems
      problems.split ', '
    end

    def advice_for problems
      advisories = list_of(problems).inject([]) do |advice, for_the_problem| 
        advice << @assistant.recall_the(:advisories).fetch(for_the_problem)
      end
      advisories.join(" ")
    end
  end
end
