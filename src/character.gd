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

extends Node2D

# I'm not sure if I'm going to support all of these yet
enum TYPE {HERO = 1, VILLAIN = 2, GUARD = 3, ELITE_GUARD = 4, CAPTAIN = 5, MONSTER = 6, SPRINTER = 7, TANK = 8}
enum DIRECTION {UP = 1, RIGHT = 2, DOWN = 3, LEFT = 4}

@export
var grid_x = 0
@export
var grid_y = 0

@export
var type = TYPE.GUARD

var alive = true

var sprite: AnimatedSprite2D

func kill():
  alive = false
  visible = false

func grid_position() -> Vector2i:
  return Vector2i(grid_x, grid_y)

func move(delta_x: int, delta_y: int):
  grid_x += delta_x
  grid_y += delta_y
  position = Vector2(grid_x * 16, grid_y * 16)

func x_with_offset(delta: int) -> int:
  return grid_x + delta

func y_with_offset(delta: int) -> int:
  return grid_y + delta

func _ready():
  sprite = get_node("Sprite")

  move(0, 0)
  MoveService.register_character(self)
  match type:
    TYPE.HERO:
      sprite.sprite_frames = preload("res://spriteframes/hero.tres")
    TYPE.VILLAIN:
      modulate = Color(1, 0.4, 0.4)
    TYPE.GUARD:
      modulate = Color(0.4, 0.4, 1)
    TYPE.MONSTER:
      modulate = Color(1, 0.8, 0.4)

  sprite.animation = "idle"

