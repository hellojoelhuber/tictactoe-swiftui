//
//  CreateGameView.swift
//  TicTacToeSwiftUI
//
//  Created by Joel Huber on 6/1/22.
//

import SwiftUI

struct CreateGameView: View {
    @EnvironmentObject var auth: Auth
    @EnvironmentObject var gameVM: GameViewModel
//    @Environment(\.dismiss) var dismiss
    
//    var DismissButton: some View {
//        Button("Dismiss") {
//            dismiss()
//        }
//    }
    
    @State var rows: Int = 3
    @State var columns: Int = 3
    @State var isPasswordProtected: Bool = false
    @State var password: String = ""
    @State var isMutualFollowsOnly: Bool = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Grid Size").textCase(.uppercase)) {
                    Stepper("Rows\t\(rows)", value: $rows, in: 3...7)
                    Stepper("Columns\t\(columns)", value: $columns, in: 3...7)
                    
                }
                Section(header: Text("Security").textCase(.uppercase)) {
                    Toggle("Password Protected?", isOn: $isPasswordProtected)
                    TextField("Password", text: $password)
                        .opacity(isPasswordProtected ? 1 : 0)
                    
                    Toggle("Mutual Follows Only?", isOn: $isMutualFollowsOnly)
                }
            }
            .navigationBarTitle("Create Game", displayMode: .inline)
            .navigationBarItems(
                leading: Cancel,
                trailing: CreateGame
            )
        }
//        .alert(isPresented: $til.showingErrorAlert) {
//            Alert(title: Text("Error"), message: Text("There was a problem saving the user"))
//        }
    }
    
    private var CreateGame: some View {
        Button(action: {
            gameVM.createGame(row: rows,
                              col: columns,
                              password: isPasswordProtected ? password : nil,
                              isMutualsOnly: isMutualFollowsOnly,
                              auth: auth)
        }) {
            Text("Save")
        }
    }
    
    private var Cancel: some View {
        Button(action: {
            gameVM.showingModalView.toggle()
        }, label: {
            Text("Cancel")
                .fontWeight(Font.Weight.regular)
        })
    }
}
