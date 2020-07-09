def create_grid
  grid = Array.new(0)
  3.times do |y|
    3.times do |x|
      grid[x + y * 3] = " "
    end
  end

  return grid
end

def draw_grid(grid)
  system "clear"

  3.times do |y|
    3.times do |x|
      draw_case(grid, x + y * 3)
    end
  end
end

def draw_case(grid, case_number)
  if grid[case_number] == " "
    print "|#{case_number + 1}"
  end

  if grid[case_number] == "X" || grid[case_number] == "O"
    print "|#{grid[case_number]}"
  end

  if case_number > 1 && (case_number + 1) % 3 == 0
    puts "|"
  end
end

def ask_input(grid, player)
  print "Votre choix : "
  player_input = gets.chomp.to_i

  while !input_valid?(grid, player_input)
    print "Votre choix : "
    player_input = gets.chomp.to_i
  end

  grid[player_input - 1] = player

  return grid
end

def input_valid?(grid, player_input)
  if player_input < 1 || player_input > 9
    puts "Mauvais chiffre"
    return false
  end

  if grid[player_input - 1] != " "
    puts "Pas possible !"
    return false
  end

  return true
end

def switch_player(player)
  return "X" if player == "O"
  return "O"
end

def is_won?(grid)
  # Horizontal
  3.times do |y|
    winner = grid[y * 3]
    is_win = true

    3.times do |x|
      if winner == " " || grid[x + y * 3] != winner
        is_win = false
      end
    end

    if is_win
      return true
    end
  end

  # Vertical
  3.times do |x|
    winner = grid[x]
    is_win = true

    3.times do |y|
      if winner == " " || grid[x + y * 3] != winner
        is_win = false
      end
    end

    if is_win
      return true
    end
  end

  # Diagonal 1
  winner = grid[0]
  is_win = true

  3.times do |i|
    if winner == " " || grid[i + i * 3] != winner
      is_win = false
    end
  end

  if is_win
    return true
  end

  # Diagonal 2
  winner = grid[2]
  is_win = true

  3.times do |i|
    if winner == " " || grid[(2 - i) + i * 3] != winner
      is_win = false
    end
  end

  if is_win
    return true
  end

  return false
end

def end_game?(grid)
  return false if grid.count(" ") > 0
  return true
end

def perform
  player_turn = "X"
  grid = create_grid()

  while !is_won?(grid) && !end_game?(grid) do
    draw_grid(grid)
    grid = ask_input(grid, player_turn)
    player_turn = switch_player(player_turn)
  end

  draw_grid(grid)

  if is_won?(grid)
    player_turn = switch_player(player_turn)
    puts "Bravo #{player_turn} !"
  elsif end_game?(grid)
    puts "Mince... pas de gagnant !"
  end
end

perform()
