module GridMatching
  def format_grid(grid)
    grid.map do |row|
      row.join("")
    end.join("\n").gsub(/\s*$/,"")
  end

  def match_grid(a, b)
    a = strip_whitespace(format_grid(a))
    b = strip_whitespace(b.strip_heredoc.chomp.gsub(/\s*$/, ""))

    expect(a).to eq b
  end

  def strip_whitespace(a)
    a.gsub(/^\s*/, "")
  end
end
