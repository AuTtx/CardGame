//
//  File.swift
//  lec01
//
//  Created by 许智尧 on 2023/4/2.
//

import SwiftUI //ViewModel is a part of UI ,but is not a part of View.So it can import SwiftUI
               //ViewModel's job is to be an intermediary between the model and the view
               //many times,viewmodels create its own models.Sometimes we can think viewmodel as the truth for the UI
               //viewmodel funct as a gatekeeper,访问权限



class EmojiMemoryGame: ObservableObject{
//    private(set) var model : MemoryGame<String> //private （set） read only
    
    typealias Card = MemoryGame<String>.Card
    
    static let emojis = ["🚗","🚕","🚎","🚒","🛻","🏎️","🚊","🏍️","🚄","✈️","🚁","🛥️"]

    //create a model which is modified by static , sharing by all the views
    static func createMemoryGame() -> MemoryGame<String>{
        MemoryGame<String>(numberOfPairsOfCards: 5){ pairIndex in
            emojis[pairIndex]
        }
    }
    

    
    // to ensure security
    @Published private var model = createMemoryGame()           //每次model的改变会通知view
    var cards : Array<Card>{
         model.cards
    }
    
    
    //MARK: -Intent(s)
    func choose(_ card : Card){
        model.choose(card)
    }
    
}

