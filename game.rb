# frozen_string_literal: true

require 'io/console'

class Game
  def initialize(snakes:, ladders:)
    @snakes = snakes
    @ladders = ladders
    @state = {
      turn: 1,
      previous_location: 1,
      current_location: 1,
      finished: false
    }

    lets_roll
  end

  def lets_roll
    puts "Welcome to Snakes & Ladders!\n"

    while @state[:finished] == false
      puts "\n##{@state[:turn]} | Press SPACE to roll the 🎲"

      roll! && break if STDIN.getch == ' '
    end
  end

  def roll!
    result = rand(1...6)

    puts "\n\Starting square: #{@state[:current_location]}\n" \
         "You've rolled: #{result}\n"

    @state.merge!(
      turn: @state[:turn] + 1,
      previous_location: @state[:current_location],
      current_location: move_by(result)
    )

    puts "You move to: #{@state[:current_location]}"
    finish! if @state[:current_location] >= 25
  end

  def move_by(steps)
    intended_location = @state[:current_location] + steps

    if (location = @snakes[intended_location])
      puts "🐍 Oh no! You've encountered a snake at square #{intended_location}!"
    elsif (location = @ladders[intended_location])
      puts "🚀 Hey! A ladder at square #{intended_location}!"
    else
      location = intended_location
    end

    location
  end

  def finish!
    @state[:finished] = true
    puts "\n🏁 Congratulations! You've finished the game in #{@state[:turn] - 1} turns."
  end
end
