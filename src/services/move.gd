# An entry for the GMTK gamejam 2023
# Copyright (C) 2023  Damy Metzke
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>. 

extends Node

const Character = preload("res://src/character.gd")

enum TYPE {HERO = 1, VILLAIN = 2, GUARD = 3, ELITE_GUARD = 4, CAPTAIN = 5, MONSTER = 6, SPRINTER = 7, TANK = 8}

var characters: Array[Character] = []
var target = TYPE.HERO
var grid: TileMap

func register_character(value: Character):
  characters.push_back(value)

func register_grid(value: TileMap):
  grid = value

func apply_player_move(delta_x: int, delta_y: int):
  for character in characters:
    if character.type != target:
      continue

    if not grid:
      character.move(delta_x, delta_y)
      continue

    var x = character.x_with_offset(delta_x)
    var y = character.y_with_offset(delta_y)

    var data = grid.get_cell_tile_data(0, Vector2i(x, y))

    if data.get_custom_data("solid"):
      continue

    character.move(delta_x, delta_y)

func _process(_delta):
  if Input.is_action_just_pressed("move_up"):
    apply_player_move(0, -1)
  if Input.is_action_just_pressed("move_right"):
    apply_player_move(1, 0)
  if Input.is_action_just_pressed("move_down"):
    apply_player_move(0, 1)
  if Input.is_action_just_pressed("move_left"):
    apply_player_move(-1, 0)