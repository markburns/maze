module GridMatching
  def format_grid(grid)
    grid.map do |row|
      row.join("")
    end.join("\n").gsub(/\s*$/,"")
  end

  def match_grid(a, b)
    expect(format_grid(a)).to eq b.strip_heredoc.chomp.gsub(/\s*$/, "")
  end
end
