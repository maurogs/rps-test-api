# Rock, Paper, Scissors Game API

## Description

`rps-test-api` allows you to play Rock, Paper, Scissors Game via API.

The current version of the API has the following constraints:
  - A player plays vs the machine.
  - There is only one game set.
  - If there is a dead heat, it allows the player to play again until a tie-breaker.

In order to play the game, the API has two requests:
- `POST /play`: Endpoint to allow users send a movement. Params:
  - `name`: Name of the player
  - `move`: Player movement. There are only three available options: "rock", "paper" or "scissors"
  * If the game does not exist for the current player (or it is in 'finished' status), it will create a new game.

  Response example:
  ```
    {
      "moves": [
        {
          "name": "Ponky",
          "move": "rock"
        },
        {
          "name": "Bot",
          "move": "scissor"
        }
      ],
      "result": "Ponky wins"
    }
  ```

- `GET /games`: It returns a list of all the saved games. Response is managed by a serializer.

  * This endpoint is paginated

  Response example:
  ```
  {
    "games": [
      {
        "moves_list": [
          {
            "move": "rock",
            "name": "Tony"
          },
          {
            "move": "paper",
            "name": "Bot"
          }
        ],
        "game_result": "Bot wins",
        "played_at": "2021-05-25T21:01:12.806Z"
      },
      {
        "moves_list": [
          {
            "move": "paper",
            "name": "Tony"
          },
          {
            "move": "scissors",
            "name": "Bot"
          }
        ],
        "game_result": "Bot wins",
        "played_at": "2021-05-25T21:01:12.812Z"
      }
    ],
    "meta": {
      "current_page": 1,
      "next_page": 2,
      "prev_page": null,
      "total_pages": 2,
      "total_count": 5
    }
  }
  ```

### Requirements

**Ruby version:** 2.7.2

**Database:** Postgresql

## How to run

#### **Install dependencies**

```
bundle install
```

#### **Create database**

```
rake db:create
```

#### **Run migrations**

```
rake db:migrate
```

#### **Load seed data**

```
rake db:seed
```

#### **Run the tests**

```
rspec
```

#### **Run Linters**

```
rubocop
```

#### **Added Gems**

`rspec-rails`, `active_model_serializers`, `will_paginate`

## Improvements

- Allow multiplayer: player 1 vs player 2
- Add versioning
- Add API documentation
- Add error handler to manage API errors. This may include logging, error tracking or observability tools


