//
//  GameGrid.swift
//  Gobang
//
//  Created by 李招雄 on 2020/7/4.
//  Copyright © 2020 李招雄. All rights reserved.
//

import SwiftUI

enum ItemType {
    case none, black, white
}

struct GridItem {
    var type = ItemType.none
    var color: UIColor {
        switch type {
        case .black: return UIColor.black
        case .white: return UIColor.white
        default: return UIColor.clear
        }
    }
}

class GameGrid: ObservableObject {
    let rowCount = 15
    let type = ItemType.black
    private(set) var sideLength: CGFloat = 0
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
    
    // MARK: - Check Win
    
    func checkWin(row: Int, column: Int) -> Bool {
        guard items[row][column].type != .none else {
            return false
        }
        // horizontal
        if checkWinHorizontal(row: row, column: column) {
            return true
        }
        // vertical
        if checkWinVertical(row: row, column: column) {
            return true
        }
        // lefttop to rightbottom
        if checkWinLefttopToRightbottom(row: row, column: column) {
            return true
        }
        // lefttop to rightbottom
        if checkWinRighttopToLeftbottom(row: row, column: column) {
            return true
        }
        return false
    }
    
    private func checkWinRighttopToLeftbottom(row: Int, column: Int) -> Bool {
        var count = 1
        var r = row - 1
        var c = column + 1
        while checkItem(row: r, column: c) {
            r -= 1
            c += 1
            count += 1
            if count >= 5 {
                return true
            }
        }
        r = row + 1
        c = column - 1
        while checkItem(row: r, column: c) {
            r += 1
            c -= 1
            count += 1
            if count >= 5 {
                return true
            }
        }
        return false
    }
    
    private func checkWinLefttopToRightbottom(row: Int, column: Int) -> Bool {
        var count = 1
        var r = row - 1
        var c = column - 1
        while checkItem(row: r, column: c) {
            r -= 1
            c -= 1
            count += 1
            if count >= 5 {
                return true
            }
        }
        r = row + 1
        c = column + 1
        while checkItem(row: r, column: c) {
            r += 1
            c += 1
            count += 1
            if count >= 5 {
                return true
            }
        }
        return false
    }
    
    private func checkWinVertical(row: Int, column: Int) -> Bool {
        var count = 1
        var c = column - 1
        while checkItem(row: row, column: c) {
            c -= 1
            count += 1
            if count >= 5 {
                return true
            }
        }
        c = column + 1
        while checkItem(row: row, column: c) {
            c += 1
            count += 1
            if count >= 5 {
                return true
            }
        }
        return false
    }
    
    private func checkWinHorizontal(row: Int, column: Int) -> Bool {
        var count = 1
        var r = row - 1
        while checkItem(row: r, column: column) {
            r -= 1
            count += 1
            if count >= 5 {
                return true
            }
        }
        r = row + 1
        while checkItem(row: r, column: column) {
            r += 1
            count += 1
            if count >= 5 {
                return true
            }
        }
        return false
    }
    
    private func checkItem(row: Int, column: Int) -> Bool {
        if row < 0 || row >= rowCount {
            return false
        }
        if column < 0 || column >= rowCount {
            return false
        }
        return items[row][column].type == type
    }
}
