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
        VStack{
            gamebody
            shuffle
        }
        .padding(.horizontal)
        .foregroundColor(.orange)
    }
    
//    @State private var dealt = Set<Int>()
    
    
    var gamebody: some View{
        AspectVGrid(items: game.cards,aspectRatio: 2/3){ card in
            if card.isMatched && !card.isFacedUp{
//                Rectangle().opacity(0)
                Color.clear
            }else {
                MyCardView(card)
                    .padding(4)
                    .aspectRatio(2/3,contentMode: .fit)
                    .transition(AnyTransition.scale)
                    .onTapGesture {
                        withAnimation{
                            game.choose(card)
                        }
                    }
            }
        }
//        .onAppear{
//            //deal cards
//        }
    }
    
    var shuffle: some View {
        Button("Shuffle"){
            withAnimation{
                game.shuffle()
            }
            
        }
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
                    //Pie todo...
                Text(card.isMatched ?  "🥳": card.content)
//                Text(card.content)
//                    .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
                    .animation(Animation.easeInOut(duration: 2))
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
                    
//                    .rotationEffect(<#T##angle: Angle##Angle#>)
                }
            .modifier(Cardify(isFacedUp: card.isFacedUp))
        }
    }
    private func scale(thatFits size: CGSize ) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    
    
    private struct  DrawingConstants{
        static let fontScale:CGFloat = 0.8
        static let fontSize: CGFloat = 32
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
//        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
    }
}


