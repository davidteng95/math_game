require_relative 'question'
require_relative 'player'

class Game
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @current_player = player1
  end

  def create_question
    @question = Question.new
  end

  def check_answer?(answer)
    @question.check_answer?(answer)
  end

  def switch_player
    @current_player = (@current_player == @player1) ? @player2 : @player1
  end

  def game_over?
    @player1.lives == 0 || @player2.lives == 0
  end

  def winner
    @player1.lives > @player2.lives ? @player1 : @player2
  end

  def game_session
    puts "-------- NEW GAME --------"
    until game_over?
      create_question
      puts "#{@current_player.name}: #{@question.question_text}"
      print "> "
      answer = gets.chomp.to_i

      if check_answer?(answer)
        puts "#{@current_player.name}: Yes! That is correct."
      else
        puts "#{@current_player.name}: Seriously? No!"
        @current_player.incorrect_answer
      end

      puts "#{@player1.name}: #{@player1.lives}/3 vs #{@player2.name}: #{@player2.lives}/3"
      puts "-------- NEW TURN --------"
      switch_player
    end
  end

  def game_start
    game_session
    puts "#{winner.name} wins with a score of #{winner.lives}/3"
    puts "-------- GAME OVER --------"
    puts "Good bye!"
  end
end