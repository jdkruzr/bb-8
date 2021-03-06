Slack-Gamebot
=============

[![Add to Slack](https://platform.slack-edge.com/img/add_to_slack@2x.png)](http://playplay.io)

Or roll your own ...

[![Build Status](https://travis-ci.org/dblock/slack-gamebot.svg)](https://travis-ci.org/dblock/slack-gamebot)
[![Code Climate](https://codeclimate.com/github/dblock/slack-gamebot/badges/gpa.svg)](https://codeclimate.com/github/dblock/slack-gamebot)
[![Dependency Status](https://gemnasium.com/dblock/slack-gamebot.svg)](https://gemnasium.com/dblock/slack-gamebot)

A generic game bot for slack. Works for ping-pong (2, 4 or more players), chess, etc. Inspired by [slack-pongbot](https://github.com/andrewvy/slack-pongbot), but more robust, generic and easier to improve and contribute to.

![](screenshots/game.gif)

## Installation

Create a new Bot Integration under [services/new/bot](http://slack.com/services/new/bot). Note the API token.
You will be able to invoke gamebot by the name you give it in the UI above.

Run `SLACK_API_TOKEN=<your API token> GAMEBOT_SECRET=secret foreman start`

## Production Deployment

See [DEPLOYMENT](DEPLOYMENT.md)

## Usage

Start talking to your bot!

![](screenshots/hi.png)

### Commands

#### gamebot

Shows GameBot version and links.

#### gamebot hi

Politely says 'hi' back.

#### gamebot help

Get help.

#### gamebot register

Registers a user.

![](screenshots/register.gif)

This command can also update a user's registration, for example after the user has been renamed. The bot notices user renames, but this may be necessary if the bot wasn't running during that operation.

```
gamebot register

Welcome back Victor Barna! I've updated your registration.
```

#### gamebot challenge <opponent>, ... [with <teammate>, ...]

Creates a new challenge between you and an opponent.

```
gamebot challenge @WangHoe

Victor Barna challenged Wang Hoe to a match!
```

You can create group challenges, too. Both sides must have the same number of players.

```
gamebot challenge @WangHoe @ZhangJike with @DengYaping

Victor Barna and Deng Yaping challenged Wang Hoe and Zhang Jike to a match!
```

#### gamebot accept

Accept a challenge.

```
gamebot accept

Wang Hoe and Zhang Jike accepted Victor Barna and Deng Yaping's challenge.
```

#### gamebot lost [score, ...]

Record your loss.

![](screenshots/lost.gif)

You cannot record a win.

Record your loss with a score, loser first.

```
gamebot lost 5:21

Match has been recorded! Wang Hoe crushed Victor Barna.
```

You can record scores for an entire match.

```
gamebot lost 15:21 21:17 18:21

Match has been recorded! Wang Hoe defeated Victor Barna.
```

You can record scores for a match you have already lost.

```
gamebot lost

Match has been recorded! Wang Hoe defeated Victor Barna.

gamebot lost 15:21 21:17 18:21

Match scores have been updated! Wang Hoe defeated Victor Barna.
```

#### gamebot draw

Draws a challenge, records a tie. All other players will also have to draw to record a match.

```
gamebot draw

Match is a draw, waiting to hear from Victor Barna.

gamebot draw

Match has been recorded. Victor Barna tied with Zhang Jike.
```

#### gamebot decline

Decline a challenge.

```
gamebot decline

Wang Hoe and Zhang Jike declined Victor Barna and Deng Yaping's challenge.
```

#### gamebot cancel

Cancel a challenge.

```
gamebot cancel

Victor Barna and Deng Yaping canceled a challenge against Wang Hoe and Zhang Jike.
```

#### gamebot leaderboard [number|infinity]

Get the leaderboard.

```
gamebot leaderboard

1. Victor Barna: 3 wins, 2 losses (elo: 148)
2. Deng Yaping: 1 win, 3 losses (elo: 24)
3. Wang Hoe: 0 wins, 1 loss (elo: -12)
```

The leaderboard contains 3 topmost players ranked by [Elo](http://en.wikipedia.org/wiki/Elo_rating_system), use _leaderboard 10_ or _leaderboard infinity_ to see 10 players or more, respectively.

#### gamebot matches

Displays match totals in the current season.

```
gamebot matches

Victor Barna defeated Wang Hoe 3 times
Deng Yaping defeated Victor Barna once
```

You can also get match totals for specific players.

```
gamebot matches @WangHoe

Victor Barna defeated Wang Hoe 5 times
Wang Hoe defeated Deng Yaping twice
```

#### gamebot challenges

Displays all outstanding (proposed and accepted) challenges.

#### gamebot rank [<player> ...]

Show the smallest range of ranks for a list of players.  If no user is specified, your rank is shown.

```
gamebot rank @WangHoe @DengYaping

2. Deng Yaping: 1 win, 3 losses (elo: 24)
3. Wang Hoe: 0 wins, 1 loss (elo: -12)
```

#### gamebot promote <player> ...

Promotes other users to captain. Must be a captain to do that.

```
gamebot promote @WangHoe @DengYaping

Victor Barna promoted Wang Hoe and Deng Yaping to captain.
```

#### gamebot demote me

Demotes from captain to a normal user. Must be a captain and the team must have other captains to do this.

```
gamebot demote me

Victor Barna is no longer captain.
```

#### gamebot team

Display current team's info, including captains.

```
gamebot team

Team _China_, captains Deng Yaping and Victor Barna.
```

#### gamebot reset <team name>

Reset all users and pending challenges and start a new season. Must be a captain to do this.

```
gamebot reset China

Welcome to the new season!
```

#### gamebot season

Display current season's leader and game totals.

```
gamebot season

Current: Deng Yaping: 1 win, 0 losses (elo: 48), 1 game, 2 players
```

#### gamebot seasons

Display current season's leader, past seasons' winners and game totals.

```
gamebot seasons

Current: Deng Yaping: 1 win, 0 losses (elo: 48), 1 game, 2 players
2015-07-16: Wang Hoe: 28 wins, 19 losses (elo: 214), 206 games, 25 players
```

## API

Slack-gamebot implements a Hypermedia API. Navigate to the application root to browse through available objects and methods. PlayPlay.io's Ping-Pong Gamebot is [here](http://pong.playplay.io), you can see [dblock's current ping-pong elo here](http://pong.playplay.io/users/5543f64d6237640003000000).

![](screenshots/api.png)

We recommend [HyperClient](https://github.com/codegram/hyperclient) to query the API programmatically in Ruby.

## Contributing

This bot is built with [slack-ruby-bot](https://github.com/dblock/slack-ruby-bot). See [CONTRIBUTING](CONTRIBUTING.md).

## Copyright and License

Copyright (c) 2015, Daniel Doubrovkine, Artsy and [Contributors](CHANGELOG.md).

This project is licensed under the [MIT License](LICENSE.md).
