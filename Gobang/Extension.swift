//
//  Extension.swift
//  Gobang
//
//  Created by 李招雄 on 2020/7/4.
//  Copyright © 2020 李招雄. All rights reserved.
//

import SwiftUI
import UIKit

extension Image {
    static func image(color: UIColor, size: CGFloat) -> Image {
        UIGraphicsBeginImageContextWithOptions((CGSize(width: size, height: size)), false, UIScreen.main.scale)
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setFillColor(color.cgColor)
        ctx?.fill(CGRect(origin: .zero, size: CGSize(width: size, height: size)))
        let uiImage = UIGraphicsGetImageFromCurrentImageContext()
        let image = Image(uiImage: uiImage ?? UIImage())
        UIGraphicsEndImageContext()
        return image
    }
}
