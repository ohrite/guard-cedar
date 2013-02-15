require "spec_helper"

describe Guard::Cedar::Runner do
  let(:options) do
    {
      project_path: "terrifying-sputum.xcodeproject",
      target: "IMissRSpec"
    }
  end
  let(:runner) { Guard::Cedar::Runner.new(options) }

  describe "#configuration" do
    it "returns Debug by default" do
      runner.configuration.should == "Debug"
    end

    context "when the configuration option is set" do
      before { options[:configuration] = "Release" }

      it "returns Release" do
        runner.configuration.should == "Release"
      end
    end
  end

  describe "#sdk_version" do
    it "returns 6.1 by default" do
      runner.sdk_version.should == "6.1"
    end

    context "when sdk_version is set" do
      before { options[:sdk_version] = "0.1" }

      it "returns the version" do
        runner.sdk_version.should == "0.1"
      end
    end
  end

  describe "#run" do
    before { runner.stub(compile: true, execute: true) }

    it "compiles the code" do
      runner.should_receive(:compile)
      runner.run
    end

    it "executes the cedar app" do
      runner.should_receive(:execute)
      runner.run
    end

    context "when compilation fails" do
      before { runner.stub(compile: false) }

      it "does not execute the cedar app" do
        runner.should_not_receive(:execute)
        runner.run
      end
    end
  end

  describe "#compile" do
    it "runs xcodebuild" do
      runner.should_receive(:system).with do |command, options|
        command.should include "xcodebuild"
      end
      runner.compile
    end

    it "runs against the project" do
      runner.should_receive(:system).with do |command, options|
        command.should include " -project terrifying-sputum.xcodeproject "
      end
      runner.compile
    end

    it "runs against the target" do
      runner.should_receive(:system).with do |command, options|
        command.should include " -target IMissRSpec "
      end
      runner.compile
    end
  end

  describe "#execute" do
    it "runs the target app" do
      runner.should_receive(:system).with do |env, command, options|
        command.should include "IMissRSpec.app/IMissRSpec "
      end
      runner.execute
    end

    it "sets IPHONE_SIMULATOR_ROOT when running" do
      runner.should_receive(:system).with do |env, command, options|
        env["IPHONE_SIMULATOR_ROOT"].should =~ /iPhoneSimulator6.1/
      end
      runner.execute
    end

    context "with user-provided environment variables" do
      before do
        options[:env] = {
          "PANTS" => "meh",
          "CFFIXED_USER_HOME" => "/etc"
        }
      end

      it "passes environment variables through" do
        runner.should_receive(:system).with do |env, command, options|
          env["PANTS"].should == "meh"
        end
        runner.execute
      end

      it "does not trample important settings" do
        runner.should_receive(:system).with do |env, command, options|
          env["CFFIXED_USER_HOME"].should == Dir.tmpdir
        end
        runner.execute
      end
    end
  end
end
