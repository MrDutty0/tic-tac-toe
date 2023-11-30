# frozen_string_literal: true

require 'io/console'

# Can print messages to terminal and get input from user
module Promptable
  private

  def prompt_name(id)
    print "Enter player #{id} name: "
    gets.chomp
  end
end
