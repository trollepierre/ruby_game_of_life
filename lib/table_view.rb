class TableView
  def initialize()
  end

  # no magic constants please 🎩
  module Plays
    ALIVE = "alive"
    DEAD = "dead"

    def self.to_s(play)
      case play
        when Plays::ALIVE then
          '*'
        else
          '.'
      end
    end
  end

  def display (grid)
    res = ''
    line_indicies = (1..grid.height)
    line_indicies.each do |line|
      col_indicies = (1..grid.length).to_a
      str_line = col_indicies.map { |col| Plays.to_s grid.state(col, line) }
      res << str_line.join(' ')
      res << "\n"
    end
    res
  end
end
