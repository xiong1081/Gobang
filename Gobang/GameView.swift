//
//  GameView.swift
//  Gobang
//
//  Created by 李招雄 on 2020/7/4.
//  Copyright © 2020 李招雄. All rights reserved.
//

import SwiftUI

struct GameView: View {
    var grid = GameGrid()
    
    var body: some View {
        VStack {
            ForEach(0..<self.grid.rowCount, id: \.self) { i in
                HStack(spacing: 0) {
                    ForEach(0..<self.grid.rowCount, id: \.self) { j in
                        Button(action: {
                            self.grid.items[i][j] = true
                        }) {
                            Text("")
                                .cornerRadius(self.grid.sideLength/2)
                                .background(self.grid.items[i][j] ? Color.black : Color.clear)
                        }
                            .frame(width: self.grid.sideLength, height: self.grid.sideLength)
                            .background(Color(white: i%2==j%2 ? 0.9 : 0.98))
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
