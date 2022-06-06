//
//  AspectVGrid.swift
//  TicTacToeSwiftUI
//
//  Created by Joel Huber on 6/3/22.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    let minWidth: CGFloat = 20
    let columns: Int
    
    init(items: [Item], aspectRatio: CGFloat, columns: Int, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
        self.columns = columns
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    let width: CGFloat = min(max(minWidth,widthThatFits(itemCount: items.count, in: geometry.size, itemAspectRatio: aspectRatio)),100)
                    LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
                        ForEach(items) { item in
                            content(item).aspectRatio(aspectRatio, contentMode: .fit).padding(5)
                        }
                    }
                    Spacer(minLength: 0)
                }
            }
            
            .frame(maxWidth: max(geometry.size.width * 0.8,720))
            .frame(width: geometry.size.width)
        }
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }

    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
//        var columnCount = 1
//        var rowCount = itemCount
//        repeat {
//            let itemWidth = size.width / CGFloat(columnCount)
//            let itemHeight = itemWidth / itemAspectRatio
//            if CGFloat(rowCount) * itemHeight < size.height {
//                break
//            }
//            columnCount += 1
//            rowCount = (itemCount + (columnCount - 1)) / columnCount
//        } while columnCount < itemCount
//        if columnCount > itemCount {
//            columnCount = itemCount
//        }
        return floor(size.width / CGFloat(columns))
    }
}
