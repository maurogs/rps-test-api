Player.destroy_all
Game.destroy_all

player_one = Player.create(name: 'Tony')
player_two = Player.create(name: 'John')
player_three = Player.create(name: 'Alex')
player_four = Player.create(name: 'Carl')

moves_one = { 
              name: player_one.name,
              move: Game::MOVES[0],
              moved_at: Time.zone.now
            },
            {
              name: 'Bot',
              move: Game::MOVES[1],
              moved_at: Time.zone.now
            }
Game.create(player_id: player_one.id, status: 1, moves: moves_one, player_wins: false)

moves_two = { 
              name: player_one.name,
              move: Game::MOVES[1],
              moved_at: Time.zone.now
            },
            {
              name: 'Bot',
              move: Game::MOVES[2],
              moved_at: Time.zone.now
            }            
Game.create(player_id: player_one.id, status: 1, moves: moves_two, player_wins: false)

moves_three = { 
              name: player_two.name,
              move: Game::MOVES[0],
              moved_at: Time.zone.now
            },
            {
              name: 'Bot',
              move: Game::MOVES[0],
              moved_at: Time.zone.now
            },
            { 
              name: player_two.name,
              move: Game::MOVES[0],
              moved_at: Time.zone.now
            },
            {
              name: 'Bot',
              move: Game::MOVES[2],
              moved_at: Time.zone.now
            }            
Game.create(player_id: player_one.id, status: 1, moves: moves_three, player_wins: true)

moves_four = { 
              name: player_three.name,
              move: Game::MOVES[2],
              moved_at: Time.zone.now
            },
            {
              name: 'Bot',
              move: Game::MOVES[2],
              moved_at: Time.zone.now
            },
            { 
              name: player_three.name,
              move: Game::MOVES[2],
              moved_at: Time.zone.now
            },
            {
              name: 'Bot',
              move: Game::MOVES[0],
              moved_at: Time.zone.now
            }            
Game.create(player_id: player_one.id, status: 1, moves: moves_four, player_wins: false)

moves_five = { 
              name: player_three.name,
              move: Game::MOVES[0],
              moved_at: Time.zone.now
            },
            {
              name: 'Bot',
              move: Game::MOVES[2],
              moved_at: Time.zone.now
            }            
Game.create(player_id: player_one.id, status: 1, moves: moves_five, player_wins: true)

moves_six = { 
              name: player_three.name,
              move: Game::MOVES[2],
              moved_at: Time.zone.now
            },
            {
              name: 'Bot',
              move: Game::MOVES[1],
              moved_at: Time.zone.now
            }            
Game.create(player_id: player_one.id, status: 1, moves: moves_six, player_wins: true)

moves_six = { 
              name: player_four.name,
              move: Game::MOVES[1],
              moved_at: Time.zone.now
            },
            {
              name: 'Bot',
              move: Game::MOVES[2],
              moved_at: Time.zone.now
            }            
Game.create(player_id: player_one.id, status: 1, moves: moves_six, player_wins: false)

moves_seven = { 
              name: player_four.name,
              move: Game::MOVES[2],
              moved_at: Time.zone.now
            },
            {
              name: 'Bot',
              move: Game::MOVES[2],
              moved_at: Time.zone.now
            },
            { 
              name: player_four.name,
              move: Game::MOVES[1],
              moved_at: Time.zone.now
            },
            {
              name: 'Bot',
              move: Game::MOVES[1],
              moved_at: Time.zone.now
            } ,
            { 
              name: player_four.name,
              move: Game::MOVES[1],
              moved_at: Time.zone.now
            },
            {
              name: 'Bot',
              move: Game::MOVES[0],
              moved_at: Time.zone.now
            }            
Game.create(player_id: player_one.id, status: 1, moves: moves_seven, player_wins: true)

moves_eight = { 
              name: player_four.name,
              move: Game::MOVES[2],
              moved_at: Time.zone.now
            },
            {
              name: 'Bot',
              move: Game::MOVES[0],
              moved_at: Time.zone.now
            }            
Game.create(player_id: player_one.id, status: 1, moves: moves_eight, player_wins: false)
