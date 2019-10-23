//
//  ViewController.swift
//  Buka BlackJack
//
//  Created by Oliver on 10/21/19.
//  Copyright © 2019 Addie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var totalCashLabel: UILabel!
    var totalCash:Double = 1000
    var betAmount:Double = 1
    @IBOutlet weak var betAmountLabel: UILabel!
    @IBOutlet weak var betStaticLabel: UILabel!
    
    @IBOutlet weak var betAmountStepper: UIStepper!

    @IBAction func StepperPressed(_ sender: UIStepper) {
        betAmount = sender.value
        betAmountLabel.text = String(betAmount)
    }
    
    
    let BJTable = BlackJackTable()

    @IBOutlet weak var gameOptions: UIStackView!
    
    var DealerHandImages = UIStackView()
    var PlayerHandImages = UIStackView()
    

    
    var cardImageArray = [ #imageLiteral(resourceName: "ace_of_diamonds") , #imageLiteral(resourceName: "ace_of_diamonds") , #imageLiteral(resourceName: "2_of_hearts") ,#imageLiteral(resourceName: "3_of_diamonds") ,#imageLiteral(resourceName: "4_of_spades") ,#imageLiteral(resourceName: "5_of_clubs"),
                           #imageLiteral(resourceName: "6_of_spades") ,#imageLiteral(resourceName: "7_of_spades") ,#imageLiteral(resourceName: "8_of_diamonds") ,#imageLiteral(resourceName: "9_of_spades") ,#imageLiteral(resourceName: "10_of_clubs")
                            ]
    
    @IBOutlet weak var topCard: UIImageView!
    var originalX:CGFloat = CGFloat()
    var originalY:CGFloat = CGFloat()
    
    
    func animateCardToPlayer(dur:Double, del:Double){
        
        UIView.animate(withDuration: dur,delay: del, animations: {
            self.topCard.center.y = self.view.frame.maxY - 30
                     self.topCard.center.x = self.topCard.center.x/2 + 20
        }) { (Bool) in
            self.topCard.center.x = self.originalX
            self.topCard.center.y = self.originalY
            self.getPlayerCards()
           
            
        }
    }
    func animateCardToDealer(dur:Double, del:Double, hideOn:Bool){
        
        UIView.animate(withDuration: dur,delay: del , animations: {
               self.topCard.center.x = self.topCard.center.x/2
            }) { (Bool) in
                self.topCard.center.x = self.originalX
                self.topCard.center.y = self.originalY
                self.getDealerCards(hideOne: hideOn)
                self.DealerHandImages.sizeToFit()
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalCashLabel.text = String(totalCash)
        betAmountLabel.text = String(betAmount)
        view.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        originalX = topCard.center.x
        originalY = topCard.center.y
    }
    
    @IBOutlet weak var startGame: UIButton!
    @IBAction func startGameButtonPressed(_ sender: UIButton) {
        if(sender.tag == 0){
        StartGame()

            
            if(BJTable.playerHand.getTotal() == 21){
                displayMsg(msg: "Congrats!", titl: "You got blackjack!")
                totalCash += Double(betAmount*1.5)
                
            }else{
                startGame.isHidden = true
                gameOptions.isHidden = false
                betAmountLabel.isHidden = true
                betStaticLabel.isHidden = true
                betAmountStepper.isHidden = true
            }
        }
   
    }
    

    func StartGame(){
        
        BJTable.addTwoCardsToBothHands()
        animateCardToPlayer(dur: 0.5, del: 0)
        animateCardToDealer(dur: 0.5, del: 0.5,hideOn: true)
        animateCardToPlayer(dur: 0.5, del: 1)
        animateCardToDealer(dur: 0.5, del: 1.5,hideOn: true)
    }
    
    func getPlayerCards(){
        self.view.willRemoveSubview(PlayerHandImages)
        PlayerHandImages.removeFromSuperview()
        for view in PlayerHandImages.subviews{
            PlayerHandImages.removeArrangedSubview(view)
            
        }
        var playerHand = [UIImageView]()
        for card in BJTable.playerHand.cards{
            playerHand.append(UIImageView( image: resizeImage(image: cardImageArray[card], targetSize: CGSize(width: 71,height: 111))))
            print("added" + String(card))
        }
        
        PlayerHandImages = UIStackView(frame: CGRect(x:1 , y: 1, width: 71*BJTable.playerHand.cards.count , height: 110))
        for card in playerHand{
            PlayerHandImages.addArrangedSubview(card)
        }
        PlayerHandImages.center = view.center
        PlayerHandImages.center.y = self.view.frame.maxY - 150
        PlayerHandImages.axis = .horizontal
        
        view.addSubview(PlayerHandImages)
        
        
    }
    
    func getDealerCards(hideOne:Bool){
        self.view.willRemoveSubview(DealerHandImages)
         DealerHandImages.removeFromSuperview()
        for view in DealerHandImages.subviews{
                   DealerHandImages.removeArrangedSubview(view)
               }
        var dealerHand = [UIImageView]()
        for card in BJTable.dealerHand.cards{
            dealerHand.append(UIImageView( image: resizeImage(image: cardImageArray[card], targetSize: CGSize(width: 71,height: 110))))
            print("added" + String(card))
        }
        if(hideOne == true && dealerHand.count > 0){
            dealerHand[0] = UIImageView( image: resizeImage(image: #imageLiteral(resourceName: "backOfCard"), targetSize: CGSize(width: 71,height: 111)))
        }
        
                DealerHandImages = UIStackView(frame: CGRect(x:1 , y: 1, width: 71*BJTable.dealerHand.cards.count , height: 110))
                for card in dealerHand{
                   DealerHandImages.addArrangedSubview(card)
               }
                DealerHandImages.center = view.center
                DealerHandImages.center.y = self.view.frame.minY + 150
                DealerHandImages.axis = .horizontal
               
               view.addSubview(DealerHandImages)
        
       
        
        
    }
    
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height *      widthRatio)
        }

        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    
    
    @IBAction func HitButtonPressed(_ sender: UIButton) {
        if(sender.tag == 1){
            BJTable.playerHit()
            animateCardToPlayer(dur: 0.5, del: 0)
            if(BJTable.playerHand.didBust()){
                totalCash -= betAmount
                                            totalCashLabel.text = String(totalCash)
                displayMsg(msg: "Sorry!", titl: "You have busted.")
                 BJTable.deck.checkIfShouldShuffle()
           
                
            }
        }
        
        
    }
    
    @IBAction func StandButtonPressed(_ sender: UIButton) {
        if(sender.tag == 2){
            BJTable.dealerHitUntilSeventeen()
            animateCardToDealer(dur: 0.5, del: 0, hideOn: false)
            
            if(BJTable.didDealerAndPlayerPush()){
                displayMsg(msg: "Its a push", titl: "Tie Game")
                
            }else if(BJTable.didPlayerWin()){
                    totalCash += betAmount
                totalCashLabel.text = String(totalCash)
                    displayMsg(msg: "Great Job!", titl: "You have won!")
            }else{
                totalCash -= betAmount
                             totalCashLabel.text = String(totalCash)
                displayMsg(msg: "You have lost", titl: "Sorry!")
                
            }
            BJTable.deck.checkIfShouldShuffle()
         
            
            
        }
    }
    


    
    @IBAction func DoubleButtonPressed(_ sender: UIButton) {
        if(sender.tag == 4){
            betAmount *= 2
            BJTable.playerHit()
            animateCardToPlayer(dur: 0.5, del: 0)
            let U = UIButton()
            U.tag = 2
            StandButtonPressed(U)
            
            
        }
    }
    
    
    func displayMsg(msg:String,titl:String){
        let alrt = UIAlertController(title: titl, message: msg, preferredStyle: UIAlertController.Style.alert)
        
        alrt.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (d) in
            self.BJTable.resetHands()
                     self.getPlayerCards()
                     self.getDealerCards(hideOne: true)
                     self.startGame.isHidden = false
                     self.gameOptions.isHidden = true
            self.betAmountLabel.isHidden = false
            self.betStaticLabel.isHidden = false
            self.betAmountStepper.isHidden = false
            
        }))
        self.present(alrt, animated: false)
        
    }
    
}

