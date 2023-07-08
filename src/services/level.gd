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

const LEVELS = [
  preload("res://levels/gym.tscn"),
]

var current = 0

func reset():
  MoveService.reset()
  get_tree().change_scene_to_packed(LEVELS[current])

func next_level():
  current = current + 1
  if current >= len(LEVELS):
    print("Done!!!")
    # TODO: Figure out what to do on a win
    return

  reset()