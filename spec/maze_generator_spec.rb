require 'spec_helper'

describe GridGenerator do
  let(:generator) { GridGenerator.new(10, 10, random) }

  context "with a seeded random number" do
    let(:random) { Random.new 1 }

    it "initializes the start point to a specific random location" do
      expect(generator.start_x).to eq 9
      expect(generator.start_y).to eq 5
    end

    it "initializes the finish point to a specific random location" do
      expect(generator.finish_x).to eq 9
      expect(generator.finish_y).to eq 5
    end
  end


end
