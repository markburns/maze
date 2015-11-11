class ToStringVisitor < BaseVisitor
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
end
