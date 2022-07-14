//
//  LogoPlaceholder.swift
//  TicTacToeSwiftUI
//
//  Created by Joel Huber on 6/27/22.
//

import SwiftUI
import TrapezoidShapes

struct LogoPlaceholder: View {
    var body: some View {
        ZStack {
            RoundedTrapezoid(cornerRadius: 20,
                             edgeRatio: 0.75,
                             flexibleEdge: .right)
                .fill(.green)
                .brightness(0.35)
                .shadow(radius: 10, x: 10, y: 10)
            RoundedTrapezoid(cornerRadius: 20,
                             edgeRatio: 0.75,
                             flexibleEdge: .right)
                .strokeBorder()

            VStack {
                HStack {
                    Image(systemName: "pawprint")
                        .rotationEffect(Angle(degrees: -20))
                    Image(systemName: "pawprint")
                        .rotationEffect(Angle(degrees: -10))
                    Image(systemName: "pawprint")

                    Spacer()
                }
                
                Text("async")
                Text("Tic Tac Toe")
                    .font(.system(size: 60))
                
                HStack {
                    Spacer()
                    
                    Image(systemName: "pawprint.fill")
                        
                    Image(systemName: "pawprint.fill")
                        .rotationEffect(Angle(degrees: 10))
                    Image(systemName: "pawprint.fill")
                        .rotationEffect(Angle(degrees: 20))
                }
            }
            .padding(20)
        }
    }
}

struct LogoPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        LogoPlaceholder()
    }
}
