//
//  Board.swift
//  Connect4iOS
//
//  Created by Silver-Ed Sillaots on 25.11.2020.
//

import UIKit

enum ChipColor: Int {
    case none = 0
    case firstColor = 1
    case secondColor = 2
}

class Board: NSObject {
    static var columns = 7
    static var rows = 6
    var slots = [[ChipColor]]()
    var currentPlayer: Player
    
    override init() {
        currentPlayer = Player.allPlayers[0]
        slots = Array(repeating: Array(repeating: .none, count: 6), count: 7)
        
        super.init()
    }
    
    func getChipColor(column: Int, row: Int) -> ChipColor {
        return slots[column][row]
    }
    
    func chip(column: Int, row: Int) -> ChipColor {
        return slots[column][row]
    }
    
    func set(chip: ChipColor, column: Int, row: Int) {
        slots[column][row] = chip
    }
    
    func nextEmptySlot(column: Int) -> Int? {
        for row in 0 ..< Board.rows {
            if chip(column: column, row: row) == .none {
                return row
            }
        }
        
        return nil
    }
    
    func canMove(column: Int) -> Bool {
        return nextEmptySlot(column: column) != nil
    }
    
    func add(chip: ChipColor, column: Int) {
        if let row = nextEmptySlot(column: column) {
            set(chip: chip, column: column, row: row)
        }
    }
    
    func isFull() -> Bool {
        for column in 0 ..< Board.columns {
            if canMove(column: column) {
                return false
            }
        }
        
        return true
    }
    
    func checkWin(column: Int, row: Int) -> Bool {
        var pointCount = 0
        let curChip = currentPlayer.chip
        
        //Check below.
        for row in 0..<Board.rows {
            if slots[column][row] == curChip {
                pointCount += 1
                if pointCount == 4 {
                    return true
                }
            } else { pointCount = 0 }
        }
        pointCount = 0
        
        //Check left and right.
        for col in 0..<Board.columns {
            if slots[col][row] == curChip {
                pointCount += 1
                if pointCount == 4 {
                    return true
                }
            } else { pointCount = 0 }
        }
        pointCount = 0
        
        //Check diagonal right.
        var posR = -2
        var posC = -2
        for _ in 0...5 {
            if row - posR >= 0 && column - posC >= 0 &&
                row - posR <= 5 && column - posC <= 6 {
                if slots[column-posC][row-posR] == curChip {
                    pointCount += 1
                    if pointCount == 4 {
                        return true
                    }
                } else if pointCount != 4 {
                    pointCount = 0
                }
            }
            posR += 1
            posC += 1
        }
        pointCount = 0
        
        //Check diagonal left.
        posR = -2
        posC = -2
        for _ in 0...5 {
            if row - posR >= 0 && column + posC >= 0 &&
                row - posR <= 5 && column + posC <= 6 {
                if slots[column+posC][row-posR] == curChip {
                    pointCount += 1
                    if pointCount == 4 {
                        return true
                    }
                } else if pointCount != 4 {
                    pointCount = 0
                }
            }
            posR += 1
            posC += 1
        }
        return false
    }

}
