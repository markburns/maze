class ToEmojiVisitor < BaseVisitor
  def visit_PathPoint subject
    ".#{subject.index.ljust(3, " ")}"
  end

  def visit_Wall subject
    "  ▥ "
  end

  def visit_StartPoint subject
    "🚶   "
  end

  def visit_FinishPoint subject
    "◎#{"".ljust(3, " ")}"
  end

  def visit_PathUp(subject)
    "▲#{subject.index.to_s.ljust(3, " ")}"
  end

  def visit_PathDown subject
    "▼#{subject.index.to_s.ljust(3, " ")}"
  end

  def visit_PathLeft subject
    "◀#{subject.index.to_s.ljust(3, " ")}"
  end

  def visit_PathRight subject
    "▶#{subject.index.to_s.ljust(3, " ")}"
  end
end
