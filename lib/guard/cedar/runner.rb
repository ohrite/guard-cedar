require "guard/guard"

module Guard
  class Cedar < ::Guard::Guard
    class Runner
      attr_reader :options

      def initialize(options = {})
        @options = options
      end

      def configuration
        options[:configuration] || "Debug"
      end

      def sdk_version
        options[:sdk_version] || "6.1"
      end

      def environment_options
        options[:env] || {}
      end

      def target
        options[:target]
      end

      def project_path
        options[:project_path]
      end

      def run
        return false unless compile
        execute
      end

      def compile
        system(
          compile_command,
          :out => "/dev/null"
        )
      end

      def execute
        system(
          cedar_environment,
          execute_command,
          :unsetenv_others => true
        )
      end

      private
      def cedar_environment
        environment_options.merge({
          "DYLD_ROOT_PATH" => simulator_path,
          "CFFIXED_USER_HOME" => Dir.tmpdir,
          "CEDAR_HEADLESS_SPECS" => "1",
          "CEDAR_REPORTER_CLASS" => "CDRColorizedReporter",
          "IPHONE_SIMULATOR_ROOT" => simulator_path
        })
      end

      def execute_command
        [
          cedar_app_path,
          "-RegisterForSystemEvents"
        ].join(" ")
      end

      def cedar_app_path
        File.expand_path("#{target}.app/#{target}", configuration_path)
      end

      def configuration_path
        File.expand_path("#{configuration}-iphonesimulator", build_path)
      end

      def build_path
        File.expand_path("../build", project_path)
      end

      def compile_command
        [
          xcodebuild_path,
          "-project #{project_path}",
          "-target #{target}",
          "-configuration #{configuration}",
          "-sdk iphonesimulator",
          "build"
        ].join(" ")
      end

      def xcodebuild_path
        `which xcodebuild`.strip
      end

      def xcode_developer_path
        `xcode-select -print-path`.strip
      end

      def simulator_path
        File.expand_path("iPhoneSimulator#{sdk_version}.sdk", simulator_base_path)
      end

      def simulator_base_path
        File.expand_path("Platforms/iPhoneSimulator.platform/Developer/SDKs", xcode_developer_path)
      end
    end
  end
end
