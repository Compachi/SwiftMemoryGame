//
//  MatchGameController.swift
//  LessnauKyleAdvancediOSProject2
//
//  Created by Kyle Lessnau on 10/21/16.
//  Copyright © 2016 Kyle Lessnau. All rights reserved.
//

import UIKit

class MatchGameController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let gameModel = GameModel()
    //Initilaized to 16. Should there be an error passing number from ViewController, this will be the default.
    var gameCardCount = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameModel.shuffleArrays()
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameCardCount
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! GameCollectionViewCell
        //Populates cell based on option chosen in first controller
        if(gameCardCount == 4) {
            cell.cardLabel.text = self.gameModel.twoByTwoItems[indexPath.item]
            cell.cardImagefront.backgroundColor = .black
        }
        if(gameCardCount == 16) {
            cell.cardLabel.text = self.gameModel.fourByFourItems[indexPath.item]
            cell.cardImagefront.backgroundColor = .black
        }
        if(gameCardCount == 36) {
            cell.cardLabel.text = self.gameModel.sixBySixItems[indexPath.item]
            cell.cardImagefront.backgroundColor = .black
        }
        cell.backgroundColor = UIColor.lightGray
        cell.cardLabel.isHidden = true
        return cell
    }
    
    //MARK: Resizes cells based on option picked so we have a grid. Dimensions may look a little wonky,
    //      but because we respect and love math, they are based off of the golden rectangle.
    //      Sizes should work with iPhone 6S Plus and 7.
    //
    //      REDUX!!!!! Tried adjusting cell sizes so they fit for all versions of iPhone. Removed old version.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        //Gets size of screen. Dynamic based on simulator chosen.
        let screenSize: CGRect = UIScreen.main.bounds
        //Default sizes for 4x4 game
        var width: CGFloat = screenSize.width * 0.20
        var height: CGFloat = screenSize.height * 0.20
        
        //2x2 game
        if gameCardCount == 4 {
            width = screenSize.width * 0.40
            height = screenSize.height * 0.40
        }
        //6x6 game
        if gameCardCount == 36 {
            width = screenSize.width * 0.16
            height = screenSize.height * 0.13
        }
        
        return CGSize(width: width, height: height)
    }
    
    //Game logic.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! GameCollectionViewCell
        if(cell.cardLabel.isHidden == true) {
            UIView.transition(with: cell.cardImagefront, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250), execute: {
                    cell.cardImagefront.backgroundColor = UIColor.cyan
                    cell.cardLabel.isHidden = false })
                self.gameModel.indexOfTurnedCardArray.append(indexPath.row)
                }, completion: nil)
            
            gameModel.turnedCard += 1
            
            //Once two cards have been flipped, begin the evaluation.
            if(gameModel.turnedCard == 2) {
                //Get emojis from cells to compare
                let cell1 = collectionView.cellForItem(at: [0, self.gameModel.indexOfTurnedCardArray[0]]) as! GameCollectionViewCell
                let cell2 = collectionView.cellForItem(at: [0, self.gameModel.indexOfTurnedCardArray[1]]) as! GameCollectionViewCell
                //Compares the emojis on the card and the cells disappearing until both are visible
                if(cell1.cardLabel.text == cell2.cardLabel.text) {
                    //If cards match, they are hidden and original states are reset should user reset the game after winning
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        cell1.isHidden = true
                        cell1.cardLabel.isHidden = true
                        cell1.cardImagefront.backgroundColor = .black
                        cell2.isHidden = true
                        cell2.cardLabel.isHidden = true
                        cell2.cardImagefront.backgroundColor = .black
                        self.gameModel.removedCard += 2
                        //Removes indices from array for the next two selected cards
                        self.gameModel.indexOfTurnedCardArray.removeAll()
                        //Checks if the game has been won
                        if(self.gameModel.removedCard == self.gameCardCount) {
                            self.gameModel.removedCard = 0
                            //Brings up alert message for winner
                            let alertController = UIAlertController(title: "Congratulations!", message:
                                "You win!", preferredStyle: .alert)
                            //If user resets, iterates through collection view cells and unhides them.
                            let resetAction = UIAlertAction(title: "Reset", style: UIAlertActionStyle.default) {
                                UIAlertAction in
                                for i in 0..<self.gameCardCount {
                                    collectionView.cellForItem(at: [0, i])?.isHidden = false
                                }
                            }
                            //If user dismisses, controller is popped off of stack
                            let cancelAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel) {
                                UIAlertAction in
                                //Always a warning???????
                                self.navigationController?.popToRootViewController(animated: true)
                            }
                            // Add the actions
                            alertController.addAction(resetAction)
                            alertController.addAction(cancelAction)
                            //Display alert
                            self.present(alertController, animated: true, completion: nil)
                        }
                    })
                }
                
                else {
                    //Again, before images disappear, we'll pause for a second so both emojis are visible and then flip both cells back
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            
                        UIView.transition(with: cell1.cardImagefront, duration: 0.5, options: .transitionFlipFromRight, animations: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250), execute: {
                                cell1.cardImagefront.backgroundColor = .black
                                cell1.cardLabel.isHidden = true
                            })
                        }, completion: nil)
                        
                        UIView.transition(with: cell2.cardImagefront, duration: 0.5, options: .transitionFlipFromRight, animations: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250), execute: {
                            cell2.cardImagefront.backgroundColor = .black
                            cell2.cardLabel.isHidden = true
                            })
                        }, completion: nil)
                    })
                    
                    self.gameModel.indexOfTurnedCardArray.removeAll()
                }
                gameModel.turnedCard = 0
            }
        }
    }
}

