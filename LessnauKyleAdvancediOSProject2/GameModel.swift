//
//  GameModel.swift
//  LessnauKyleAdvancediOSProject2
//
//  Created by Kyle Lessnau on 10/23/16.
//  Copyright © 2016 Kyle Lessnau. All rights reserved.
//

import Foundation

class GameModel {
    
    //This variable allows us to keep track of how many cards have been turned. Once two are turned, evaluation begins
    var turnedCard = 0
    //Keeps track of cards removed from the game. Calls alert once all cards are removed from game
    var removedCard = 0
    //Used to hold the index of the cards that were flipped by the user.
    var indexOfTurnedCardArray = [Int]()
    
    //Emojis used for card labels. 
    var twoByTwoItems = ["⚽️", "🏀", "⚽️", "🏀"]
    
    var fourByFourItems = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱",
                           "⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱"]
    
    var sixBySixItems = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🐶", "🐱", "🐭", "🐹", "🐰", "🐻", "🐼", "🐨", "👓", "🕶",
                         "⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🐶", "🐱", "🐭", "🐹", "🐰", "🐻", "🐼", "🐨", "👓", "🕶"]
    
    
    //Shuffles all arrays upon loading the MatchGameController
    func shuffleArrays() {
        
        for i in 0..<twoByTwoItems.count {
            let j = Int(arc4random_uniform(UInt32(3 - i))) + i
            if(i != j) {
                swap(&twoByTwoItems[i], &twoByTwoItems[j])
            }
        }
    
        for i in 0..<fourByFourItems.count {
            let j = Int(arc4random_uniform(UInt32(16 - i))) + i
            if(i != j) {
                swap(&fourByFourItems[i], &fourByFourItems[j])
            }
        }
        
        for i in 0..<sixBySixItems.count {
            let j = Int(arc4random_uniform(UInt32(36 - i))) + i
            if(i != j) {
                swap(&sixBySixItems[i], &sixBySixItems[j])
            }
        }
    }
}
