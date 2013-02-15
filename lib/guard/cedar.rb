require "guard"
require "guard/guard"
require "guard/cedar/runner"

module ::Guard
  class Cedar < ::Guard::Guard
    attr_reader :options

    def initialize(watchers=[], options={})
      @options = options
      super
    end

    def start
      run_all if options[:all_on_start]
    end

    def run_all
      runner.run
    end

    def run_on_changes(paths)
      run_all
    end

    private
    def runner
      ::Guard::Cedar::Runner.new(options)
    end
  end
end
  