//
//  Deck.swift
//  Buka BlackJack
//
//  Created by Oliver on 10/21/19.
//  Copyright © 2019 Addie. All rights reserved.
//

import Foundation

class DeckOfCards{

    var deckInteger = [1, 1 ,1 ,1 ,
                       2, 2, 2, 2,
                       3, 3, 3, 3,
                       4, 4, 4, 4,
                       5, 5, 5, 5,
                       6, 6, 6, 6,
                       7, 7, 7, 7,
                       8, 8, 8, 8,
                       9, 9, 9, 9,
                       10, 10, 10, 10,
                       10, 10, 10, 10,
                       10, 10, 10, 10,
                       10, 10, 10, 10 ]
    var deckPosition = 0;
    
    func shuffleDeck(){
        deckPosition = 0;
        deckInteger.shuffle()
    }
    
    func getCard() -> Int {
        let cardNumber = deckInteger[deckPosition];
        deckPosition += 1;
        return cardNumber
    }
    
    func percentOfDeckLeft() -> Double {
        return Double((deckInteger.count - deckPosition)/52)
    }
    
    func checkIfShouldShuffle(){
        // shuffling deck if less than 20% of cards are remaining
        if(percentOfDeckLeft() < 0.2 ){
            shuffleDeck()
        }
    }
    
    
}
