require "spec_helper"

describe Guard::Cedar do
  let(:guard) { Guard::Cedar.new }

  describe "#start" do
    context "when all_on_start is set" do
      before { guard.options[:all_on_start] = true }

      it "runs all the specs" do
        guard.should_receive(:run_all)
        guard.start
      end
    end

    context "when all_on_start is not set" do
      before { guard.options[:all_on_start] = false }

      it "runs all the specs" do
        guard.should_not_receive(:run_all)
        guard.start
      end
    end
  end

  describe "#run_on_changes" do
    it "runs all the specs" do
      guard.should_receive(:run_all)
      guard.run_on_changes("monkey-butt")
    end
  end
end