class MazeForm
  include ActiveModel::Model

  def self.model_name
    ActiveModel::Name.new(self, nil, "Maze")
  end

  attr_reader :maze, :size

  def initialize(size: 10)
  end

  def persisted?
    false
  end
end
