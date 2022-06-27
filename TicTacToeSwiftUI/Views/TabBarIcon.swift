//
//  TabBarIcon.swift
//  TicTacToeSwiftUI
//
//  Created by Joel Huber on 6/27/22.
//

import SwiftUI

struct TabBarIcon: View {
    @EnvironmentObject var model: GameViewModel
    
    let icon: String
    let tabName: String
    let view: Page
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top, 10)
            Text(tabName)
                .font(.footnote)
            Spacer()
        }
        .onTapGesture {
            model.currentPage = view
        }
    }
}


struct TabBarIcon_Previews: PreviewProvider {
    struct Preview: View {
        @StateObject var model = GameViewModel()
        
        var body: some View {
            TabBarIcon(icon: "hare", tabName: "Active", view: .landingPage)
                .environmentObject(model)
        }
    }
    static var previews: some View {
        Preview()
    }
}
