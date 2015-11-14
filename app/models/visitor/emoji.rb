module Visitor
  class Emoji < Base
    def visit_PathPoint _
      "."
    end

    def visit_Wall _
      "▥"
    end

    START_POINT = "🚶"

    def visit_StartPoint _
      START_POINT + "  "
    end

    def visit_FinishPoint _
      format "🚪"
    end

    def visit_PathUp _ 
      format "↑"
    end

    def visit_PathDown _
      format "↓"
    end

    def visit_PathLeft _
      format "←"
    end

    def visit_PathRight _
      format "→"
    end

    def visit_PathDeadEnd _
      format "▥"
    end

    private

    def format(s)
      " #{s} "
    end
  end
end
