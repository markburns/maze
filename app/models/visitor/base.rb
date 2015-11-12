module Visitor
  class Base
    def visit(subject)
      klass_name = subject.class.name.gsub("::","")
      method_name = "visit_#{klass_name}".intern

      send(method_name, subject )
    end
  end
end
