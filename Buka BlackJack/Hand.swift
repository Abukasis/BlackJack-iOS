//
//  Hand.swift
//  Buka BlackJack
//
//  Created by Oliver on 10/21/19.
//  Copyright © 2019 Addie. All rights reserved.
//

import Foundation

class HandOfCards{
    
    var cards = [Int]()
    
    func addCardToHand(card:Int){
        cards.append(card)
    }
    
    func getTotal() -> Int{
        var total = 0
        var aceCount = 0
        for card in cards{
            if(card == 1){
                total += 11
                aceCount += 1
            }else{
            total += card
            }
        }
        if(total > 21 && aceCount != 0){
            total = total - 10
            aceCount -= 1
        }
        print(total)
        return total
    }
    
    func didBust() -> Bool{
        if(getTotal() > 21){
            return true
        }else{
            return false
        }
    }
    
    
}
