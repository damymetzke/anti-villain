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

const OFFSETS = [
  Vector2i(-1, 0),
  Vector2i(0, 1),
  Vector2i(1, 0),
  Vector2i(0, -1),
]

func navigate(from: Vector2i, to: Vector2i, grid: TileMap):
  if from == to:
    return []

  var next = [[from, [from]]]
  var considered = {from: true}

  while len(next) > 0:
    var current = next
    next = []

    for current_value in current:
      var position = current_value[0]
      var history = current_value[1]

      for offset in OFFSETS:
        var possible = position + offset
        if considered.has(possible):
          continue

        considered[possible] = true

        if grid.get_cell_tile_data(0, possible).get_custom_data("solid"):
          continue

        if possible == to:
          history.push_back(possible)
          return history

        var next_history = history.duplicate()
        next_history.push_back(possible)
        next.push_back([possible, next_history])



