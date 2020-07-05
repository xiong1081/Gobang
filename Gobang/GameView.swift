//
//  GameView.swift
//  Gobang
//
//  Created by 李招雄 on 2020/7/4.
//  Copyright © 2020 李招雄. All rights reserved.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var grid: GameGrid
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<self.grid.rowCount, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<self.grid.rowCount, id: \.self) { column in
                        Button(action: {
                            self.grid.items[row][column].type = .black
                            if self.grid.checkWin(row: row, column: column) {
                                print("You Win!")
                            }
                        }) {
                            Image.image(color: self.grid.items[row][column].color, size: self.grid.sideLength-8)
                                .renderingMode(.original)
                                .clipShape(Circle())
                        }
                            .frame(width: self.grid.sideLength, height: self.grid.sideLength)
                            .background(Color(white: row%2==column%2 ? 0.9 : 0.98))
                            .disabled(self.grid.items[row][column].type != .none)
                    }
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
