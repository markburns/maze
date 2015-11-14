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
      START_POINT
    end

    def visit_FinishPoint _
      "◎"
    end

    def visit_PathUp _ 
      "▲"
    end

    def visit_PathDown _
      "▼"
    end

    def visit_PathLeft _
      "◀"
    end

    def visit_PathRight _
      "▶"
    end

    def visit_PathDeadEnd _
      "▥"
    end
  end
end
