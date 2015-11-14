module Visitor
  class String < Base
    def visit_PathPoint _
      "."
    end

    def visit_Wall _
      "w"
    end

    def visit_StartPoint _
      "s"
    end

    def visit_FinishPoint _
      "f"
    end

    def visit_PathUp _
      "^"
    end

    def visit_PathDown _
      "v"
    end

    def visit_PathLeft _
      "<"
    end

    def visit_PathRight _
      ">"
    end

    def visit_PathDeadEnd _
      "x"
    end
  end
end
