class MazeGenerator < Struct.new(:width, :height)
  def grid
    height.times.map do 
      width.times.map do 
        "w"
      end.join ""
    end.join "\n"
  end
end
