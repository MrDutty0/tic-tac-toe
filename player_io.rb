# frozen_string_literal: true

require 'io/console'

# Can print messages to terminal and get input from user
module PlayerIO
  CONSOLE = IO.console

  def self.congradulate_on_tie(players)
    print "#{players[0].name} and #{players[1].name} have tied!\n\n"
  end

  def self.congradulate_on_winning(winner)
    print "#{winner.name} has won!\n\n"
  end

  def self.print_score(players)
    score_types = players[0].score.keys

    puts format("%-9s %-9s %s", 'Score', players[0].name, players[1].name)

    score_types.each do |score_type|
      row = [score_type.to_s.capitalize]
      players.each { |player| row.push(player.score[score_type]) }

      puts format("%-9s %-9s %s", row[0], row[1], row[2])
    end
  end

  def self.clear_screen
    CONSOLE.erase_screen(2)
  end

  def restart?
    puts "\nRestart? (Y, other)"
    prompt_for_single_char.capitalize == 'Y'
  end

  def prompt_for_single_char
    input = $stdin.getch
    begin
      input += $stdin.read_nonblock(2)
    rescue IO::EAGAINWaitReadable
      nil
    end
    input
  end

  def prompt_move
    print "#{name.capitalize}, place your #{symbol}\n"
    print "(Navigate with arrow keys, press Enter to place your symbol)\n"
    prompt_for_single_char
  end

  private

  def prompt_name(id)
    print "Enter player #{id} name: "
    gets.chomp
  end
end
