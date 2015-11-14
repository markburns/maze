class MazesController < ApplicationController
  def new
    @maze = MazeForm.new(size: 10)
  end

  def create
    redirect_to maze_path(maze_params[:size])
  end

  def show
    size = params[:id].to_i
    grid = Grid.new size, size
    generator = MazeGenerator.new(grid)
    @maze = generator.maze
  end

  private

  def maze_params
    params.require(:maze).permit(:size)
  end
end
