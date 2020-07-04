//
//  GameGrid.swift
//  Gobang
//
//  Created by 李招雄 on 2020/7/4.
//  Copyright © 2020 李招雄. All rights reserved.
//

import SwiftUI

class GameGrid {
    let rowCount = 15
    var sideLength: CGFloat
    var items: [[Bool]] = []
    
    init() {
        sideLength = UIScreen.main.bounds.size.width / CGFloat(rowCount)
        for _ in 1...rowCount {
            var row: [Bool] = []
            for _ in 1...rowCount {
                row.append(false)
            }
            items.append(row)
        }
    }
}
