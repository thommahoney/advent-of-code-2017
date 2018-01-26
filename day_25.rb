class TuringMachine
  attr_accessor :state, :steps, :position, :tape

  RULES = {
    'A' => [1, 1, 'B', 0, -1, 'C'],
    'B' => [1, -1, 'A', 1, 1, 'C'],
    'C' => [1, 1, 'A', 0, -1, 'D'],
    'D' => [1, -1, 'E', 1, -1, 'C'],
    'E' => [1, 1, 'F', 1, 1, 'A'],
    'F' => [1, 1, 'A', 1, 1, 'E'],
  }

  def initialize(steps)
    @state = 'A'
    @tape = {}
    @position = 0

    @steps = steps
  end

  def run
    steps.times do
      tape[position] ||= 0

      instructions = RULES[state]

      tape[position], self.position, self.state = tape[position] == 0 ?
        [instructions[0], (position + instructions[1]), instructions[2]] :
        [instructions[3], (position + instructions[4]), instructions[5]]
    end

    checksum
  end

  def checksum
    tape.inject(0) do |a, (_k, v)|
      a + v
    end
  end
end

puts TuringMachine.new(12261543).run
