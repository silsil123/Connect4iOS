//
//  GameViewController.swift
//  Connect4iOS
//
//  Created by Silver-Ed Sillaots on 25.11.2020.
//

import UIKit

class GameViewController: UIViewController {
    
    var movementPermission = true
    var player1wins = 0
    var player2wins = 0
    
    var board = Board()
    
    @IBAction func newGameButton(_ sender: UIButton) {
        resetBoard()
        player1wins = 0
        player2wins = 0
        let player1Wins = self.view.viewWithTag(101) as? UILabel
        let player2Wins = self.view.viewWithTag(102) as? UILabel
        player1Wins?.text = "Player 1 wins: \(player1wins)"
        player2Wins?.text = "Player 2 wins: \(player2wins)"
    }
    
    @IBAction func clearBoardButton(_ sender: UIButton) {
        resetBoard()
        
    }
    
    @IBAction func gameBoardButtonClicked(_ sender: UIButton) {
        if movementPermission {
            let column = sender.tag / 10 - 1
            
            if board.canMove(column: column) {
                let row: Int = board.nextEmptySlot(column: column)!
                board.add(chip: board.currentPlayer.chip, column: column)
                let button = self.view.viewWithTag((column + 1) * 10 + row) as? UIButton
                button?.backgroundColor = board.currentPlayer.color
                
                var gameOverTitle: String? = nil
                
                if board.checkWin(column: column, row: row) {
                    gameOverTitle = "\(board.currentPlayer.name) Wins!"
                    if board.currentPlayer.chip == .firstColor {
                        player1wins += 1
                    } else { player2wins += 1 }
                } else if board.isFull() {
                    gameOverTitle = "Draw!"
                }
                
                if gameOverTitle != nil {
                    let alert = UIAlertController(title: gameOverTitle, message: nil, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
                        NSLog("OK Pressed") }
                    
                    movementPermission = false
                    alert.view.tintColor = UIColor.orange
                    alert.addAction(alertAction)
                    present(alert, animated: true)
                }
                let player1Wins = self.view.viewWithTag(101) as? UILabel
                let player2Wins = self.view.viewWithTag(102) as? UILabel
                player1Wins?.text = "Player 1 wins: \(player1wins)"
                player2Wins?.text = "Player 2 wins: \(player2wins)"
                
                board.currentPlayer = board.currentPlayer.opponent
            }
        }
    }
    
    @IBOutlet weak var GameBoard: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createBoard()
            
        
    }
    
    func resetBoard() {
        board = Board()
        for column in GameBoard.subviews {
            for button in column.subviews {
                button.backgroundColor = UIColor.systemOrange
            }
        }
        movementPermission = true
    }
    
    func createBoard() {
        for _ in 1 ... 7 {
            let columnStack = UIStackView()
            columnStack.axis = .vertical
            columnStack.alignment = .fill
            columnStack.distribution = .fillEqually
            columnStack.spacing = 8.0
            GameBoard.addArrangedSubview(columnStack)
        }
        
        var buttonTag = 15
        for column in GameBoard.arrangedSubviews {
            for _ in 1 ... 6 {
                let stack = column as? UIStackView
                let gameButton = UIButton()
                gameButton.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
                gameButton.tag = buttonTag
                gameButton.setTitle("", for: UIControl.State.normal)
                gameButton.addConstraint(NSLayoutConstraint(item: gameButton, attribute: .height, relatedBy: .equal, toItem: gameButton, attribute: .width, multiplier: 1, constant: 0))
                gameButton.sizeToFit()
                    
                gameButton.addTarget(self, action: #selector(gameBoardButtonClicked(_:)), for: UIControl.Event.touchUpInside)
                
                stack?.addArrangedSubview(gameButton)
                buttonTag -= 1
                
            }
            buttonTag += 16
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for column in GameBoard.subviews {
            for button in column.subviews {
                button.layer.cornerRadius = button.frame.size.width / 2
            }
        }
        var label = self.view.viewWithTag(101) as? UILabel
        label?.layer.masksToBounds = true
        label?.layer.cornerRadius = 10
        label = self.view.viewWithTag(102) as? UILabel
        label?.layer.masksToBounds = true
        label?.layer.cornerRadius = 10
        var button = self.view.viewWithTag(103) as? UIButton
        button?.layer.masksToBounds = true
        button?.layer.cornerRadius = 10
        button = self.view.viewWithTag(104) as? UIButton
        button?.layer.masksToBounds = true
        button?.layer.cornerRadius = 10
        
        
        
    }
    
            
    


}
