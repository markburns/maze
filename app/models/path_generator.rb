class PathGenerator < Struct.new :maze, :random
  def maze
    super.tap do |maze|
      add_path!(maze)
    end
  end

  def add_path!(maze)
  end
end
