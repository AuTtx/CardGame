//
//  MemoryGame.swift
//  lec01
//
//  Created by 许智尧 on 2023/4/2.
//

import Foundation //contains array,dictionary etc

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards : Array<Card>
    
    private var indexOfTheOneAndOnlyFacedUpCard: Int? {
        get{ cards.indices.filter({cards[$0].isFacedUp}).oneAndOnly }
        set{ cards.indices.forEach{cards[$0].isFacedUp = ($0 == newValue)} }
    }
        
        mutating func choose(_ card : Card){
            //argument in a function is defined as a let;self is  a immutable value
            if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
               !cards[chosenIndex].isFacedUp,
               !cards[chosenIndex].isMatched
            {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFacedUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                    cards[chosenIndex].isFacedUp = true
                }else{
                    indexOfTheOneAndOnlyFacedUpCard = chosenIndex
                }
            }
        }
        
        init(numberOfPairsOfCards: Int, createCardContent:(Int) -> CardContent){         //use a function as a input argument
            cards = []
            //add numberOfPairsOfCards times 2 cards to cards array
            for pairIndex in 0..<numberOfPairsOfCards{
                let content = createCardContent(pairIndex)         //functional programming
                cards.append(Card(content: content, id: pairIndex*2))
                cards.append(Card(content: content, id: pairIndex*2+1))
            }
        }
    
    
    struct Card : Identifiable{
        var isFacedUp = false
        var isMatched = false
        var content: CardContent
        var id: Int
        
    }
}


extension Array{
    var oneAndOnly: Element?{
        if count == 1{
            return first
        }else{
            return nil
        }
    }
}
