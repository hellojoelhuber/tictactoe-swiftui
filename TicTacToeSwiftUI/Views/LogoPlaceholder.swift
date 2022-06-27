//
//  LogoPlaceholder.swift
//  TicTacToeSwiftUI
//
//  Created by Joel Huber on 6/27/22.
//

import SwiftUI

struct LogoPlaceholder: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.green.opacity(0.4))
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
