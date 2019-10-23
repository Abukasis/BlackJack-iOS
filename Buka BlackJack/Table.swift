//
//  Table.swift
//  Buka BlackJack
//
//  Created by Oliver on 10/21/19.
//  Copyright © 2019 Addie. All rights reserved.
//

import Foundation

class BlackJackTable{
    
    let playerHand:HandOfCards
    let dealerHand:HandOfCards
    let deck:DeckOfCards
    
    
    init(){
        playerHand = HandOfCards()
        dealerHand = HandOfCards()
        deck = DeckOfCards()
        deck.shuffleDeck()
    }
    
    func startFreshHand(){
        playerHand.cards = []
        dealerHand.cards = []
        deck.checkIfShouldShuffle()
        addTwoCardsToBothHands()
    }
    
    
    
    func addTwoCardsToBothHands(){
        playerHand.addCardToHand(card: deck.getCard())
        playerHand.addCardToHand(card: deck.getCard())
        dealerHand.addCardToHand(card: deck.getCard())
        dealerHand.addCardToHand(card: deck.getCard())
    }
    
    func dealerHitUntilSeventeen(){
        while(dealerHand.getTotal() < 17){
            dealerHand.addCardToHand(card: deck.getCard())
        }
    }
    
    func playerHit(){
        playerHand.addCardToHand(card: deck.getCard())
    }
    
    func didDealerAndPlayerPush() -> Bool{
        if(playerHand.getTotal() == dealerHand.getTotal()){
            return true
        } else{
            return false
        }
    }
    
    func resetHands(){
        playerHand.cards = []
        dealerHand.cards = []
    }
    
    func didPlayerWin() -> Bool{
        if(dealerHand.getTotal() > 21){
            return true
        }
        
        if(playerHand.getTotal() > dealerHand.getTotal()){
            return true
        }else{
            return false
        }
    }
    
}
