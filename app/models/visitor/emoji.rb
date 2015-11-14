module Visitor
  class Emoji < Base
    def visit_PathPoint subject
      "."
    end

    def visit_Wall subject
      "▥"
    end

    def visit_StartPoint subject
      "　"
    end

    def visit_FinishPoint subject
      "◎"
    end

    def visit_PathUp(subject)
      "▲"
    end

    def visit_PathDown subject
      "▼"
    end

    def visit_PathLeft subject
      "◀"
    end

    def visit_PathRight subject
      "▶"
    end

    def visit_PathDeadEnd subject
      "▥"
    end
  end
end
