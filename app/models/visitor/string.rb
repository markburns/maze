module Visitor
  class String < Base
    def visit_PathPoint subject
      "."
    end

    def visit_Wall subject
      "w"
    end

    def visit_StartPoint subject
      "s"
    end

    def visit_FinishPoint subject
      "f"
    end

    def visit_PathUp subject
      "^"
    end

    def visit_PathDown subject
      "v"
    end

    def visit_PathLeft subject
      "<"
    end

    def visit_PathRight subject
      "<"
    end

    def visit_PathDeadEnd subject
      "x"
    end
  end
end
