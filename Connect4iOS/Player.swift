//
//  Player.swift
//  Connect4iOS
//
//  Created by Silver-Ed Sillaots on 25.11.2020.
//

import UIKit

class Player: NSObject {
    var chip: ChipColor
    var color: UIColor
    var name: String
    var playerId: Int
    var winCount: Int
    
    static var allPlayers = [Player(chip: .firstColor), Player(chip: .secondColor)]
    
    init(chip: ChipColor) {
        self.chip = chip
        self.playerId = chip.rawValue
        
        if chip == .firstColor {
            color = #colorLiteral(red: 0.9886431098, green: 0.8411631584, blue: 0.08218050748, alpha: 1)
            name = "Player 1"
        } else {
            color = #colorLiteral(red: 0.2278119624, green: 0.2116410434, blue: 0.2156269252, alpha: 1)
            name = "Player 2"
        }
        winCount = 0
        
        super.init()
    }
    
    var opponent: Player {
        if chip == .firstColor {
            return Player.allPlayers[1]
        } else {
            return Player.allPlayers[0]
        }
    }

}
