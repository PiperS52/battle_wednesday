require_relative 'player'
require_relative 'attack'

class Game
  attr_reader :current_turn

  def initialize(player_1, player_2)
    @players = [player_1, player_2]
    @current_turn = player_1
  end

  # class method - called on the class itself rather than an instance of the class.
  # Rather than storing state in an instance, it is stored within a class.
  # @game (a class instance variable) now doesn't go out of scope when a request/response finishes.
  def self.create(player_1, player_2)
    @game = Game.new(player_1, player_2)
  end

  # class method
  def self.instance
    @game
  end

  def player_1
    @players.first
  end

  def player_2
    @players.last
  end

  def switch_turns
    @current_turn = opponent_of(current_turn)
  end

  def opponent_of(player)
    players_who_are_not(player).first
  end

  def game_over?
    losing_players.any?
  end

  def loser
    losing_players.first
  end

  private

  attr_reader :players

  def losing_players
    players.select { |player| player.hit_points <= 0 }
  end

  def players_who_are_not(the_player)
    players.select { |player| player != the_player }
  end

end