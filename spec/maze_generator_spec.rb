require 'spec_helper'

describe MazeGenerator do
  let(:generator) { MazeGenerator.new(10, 10) }

  context "with a seeded random number" do
    let(:random) { Random.new 1 }
    let(:generator) { MazeGenerator.new(10, 10, random) }

    it "initializes the start point to a specific random location" do
      expect(generator.start_x).to eq 9
      expect(generator.start_y).to eq 5
    end
  end


end
