FIRST_PLAYER = 0
mockTeam = [
    name: 'Ivan'
    number: 11
  ,
    name: 'Edson'
    number: 3
  ,
    name: 'Pedro'
    number: 10
  ,
    name: 'cristian'
    number: 9
  ,
    name: 'Rodri'
    number: 8
  ,
    name: 'Thorsen'
    number: 1
  ,
    name: 'Wilder'
    number: 4
  ,
    name: 'Pablo'
    number: 6
]

# Default data starts from 0
defaultData = ->
  data =
    good: 0
    none: 0
    bad: 0
  data

# Basic player stats
stats = ->
  statsObject =
    spike: defaultData()
    block: defaultData()
    service: defaultData()
    set: defaultData()
    pass: defaultData()
    dig: defaultData()
  statsObject

# Adds default data to a player
# @param player [Player] object player with name a number data
addDefaultData = (player) ->
  newPlayer =
    name: player.name
    number: player.number
    stats: stats()
  newPlayer

# Adds default data score
addDefaultScore = ->
  score =
    ourTeam: 0
    contrary: 0
    contraryTeamErrors: 0
    setsInFavor: 0
    setsAgainst: 0
  score

# Match class
class Match

  constructor: ->
    @team = {}
    @score = {}

  # Creates a team to manage
  # @param team [Array<Player>] list of players to make the team
  # return matchTeam [Team] object with all players data
  createMatch: (team) ->
    @score = addDefaultScore()
    for player in team
      @team[player.number] = addDefaultData player

  # Add a good action plus 1
  # @param action [String] name of teh action
  # @param playerNumber [String] number of the player
  goodAction: (action, playerNumber) ->
    console.log action
    player = @team[playerNumber]
    player.stats[action].good++
    @score.ourTeam++

  # Add a none action plus 1
  # @param action [String] name of teh action
  # @param playerNumber [String] number of the player
  noneAction: (action, playerNumber) ->
    player = @team[playerNumber]
    player.stats[action].none++

  # Add a bad action plus 1
  # @param action [String] name of teh action
  # @param playerNumber [String] number of the player
  badAction: (action, playerNumber) ->
    player = @team[playerNumber]
    player.stats[action].bad++
    @score.contrary++

  teamError: ->


  saveMatch: ->
    @match =
      team: @team
      score: @score
    @match


match = new Match()

match.createMatch mockTeam

Template.matchScene.created = ->
  Session.set 'players', mockTeam
  Session.set 'currentPlayer', match.team[mockTeam[FIRST_PLAYER].number]

Template.matchScene.helpers
  players: ->
    Session.get 'players'
  currentPlayer: ->
    Session.get 'currentPlayer'

Template.matchScene.events
  'click .choose-player': (e) ->
    e.preventDefault()
    Session.set 'currentPlayer', match.team[@number]

  'click .good': (e) ->
    e.preventDefault()
    action = $(e.target).attr 'name'
    match.goodAction action, @number
    Session.set 'currentPlayer', match.team[@number]

  'click .none': (e) ->
    e.preventDefault()
    action = $(e.target).attr 'name'
    match.noneAction action, @number
    Session.set 'currentPlayer', match.team[@number]

  'click .bad': (e) ->
    e.preventDefault()
    action = $(e.target).attr 'name'
    match.badAction action, @number
    Session.set 'currentPlayer', match.team[@number]
