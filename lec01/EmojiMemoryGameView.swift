//
//  ContentView.swift
//  lec01
//
//  Created by 许智尧 on 2023/3/29.
//



import SwiftUI

struct EmojiMemoryGameView: View {
    
    
    @ObservedObject var game: EmojiMemoryGame //观察viewmodel which is a observable object and will publish some changes
    
    var body: some View {
        AspectVGrid(items: game.cards,aspectRatio: 2/3){ card in
            if card.isMatched && !card.isFacedUp{
                Rectangle().opacity(0)
            }else {
                MyCardView(card)
                    .padding(4)
                    .aspectRatio(2/3,contentMode: .fit)
                    .onTapGesture {
                        game.choose(card)
                    }
            }
        }
        .padding(.horizontal)
        .foregroundColor(.orange)
    }
}
    
    
struct MyCardView: View{
    private let card : MemoryGame<String>.Card
    
    init(_ givenCard: EmojiMemoryGame.Card){
        self.card = givenCard
    }
    
    var body: some View{
        GeometryReader {geometry in
            ZStack{
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFacedUp{
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content).font(font(in: geometry.size))
                }else if card.isMatched{
                    shape.opacity(0)
                }
                else{
                    shape.fill()
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height)*DrawingConstants.fontScale)
    }
    
    private struct  DrawingConstants{
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale:CGFloat = 0.8
    }
}
//var add : some View{
//        Button{
//            if count<viewmodel.cards.count{
//                self.count+=1
//            }
//        } label: {
//            Image(systemName: "plus.circle")
//        }
//    }
//
//    var remove : some View{
//        Button {
//            if count>1{
//                self.count-=1
//            }
//        } label: {
//            Image(systemName: "minus.circle")
//        }
//    }

















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
    }
}


