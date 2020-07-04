//
//  GameGrid.swift
//  Gobang
//
//  Created by 李招雄 on 2020/7/4.
//  Copyright © 2020 李招雄. All rights reserved.
//

import SwiftUI

struct GridItem {
    var type = ItemType.none
    var color: UIColor {
        switch type {
        case .black: return UIColor.black
        case .white: return UIColor.white
        default: return UIColor.clear
        }
    }
    
    enum ItemType {
        case none, black, white
    }
}

class GameGrid: ObservableObject {
    let rowCount = 15
    var sideLength: CGFloat = 0
    @Published var items: [[GridItem]] = []
    
    init() {
        sideLength = UIScreen.main.bounds.size.width / CGFloat(rowCount)
        for _ in 1...rowCount {
            var row: [GridItem] = []
            for _ in 1...rowCount {
                row.append(GridItem())
            }
            items.append(row)
        }
    }
}
