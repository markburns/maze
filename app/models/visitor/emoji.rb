module Visitor
  class Emoji < Base
    def visit_PathPoint subject
      format ".", subject
    end

    def visit_Wall subject
      "  ▥ "
    end

    def visit_StartPoint subject
      "🚶   "
    end

    def visit_FinishPoint subject
      "  ◎ "
    end

    def visit_PathUp(subject)
      format "▲", subject
    end

    def visit_PathDown subject
      format "▼", subject
    end

    def visit_PathLeft subject
      format "◀", subject
    end

    def visit_PathRight subject
      format "▶", subject
    end

    private

    def format(symbol, path_point)
      "#{symbol}#{path_point.index.to_s.ljust(3, " ")}"
    end
  end
end
