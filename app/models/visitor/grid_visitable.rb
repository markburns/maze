module Visitor
  module GridVisitable
    def accept(visitor)
      points.map do |row|
        row.map do |p|
          p.accept visitor
        end
      end
    end
  end
end
