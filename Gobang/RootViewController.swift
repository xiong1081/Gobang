//
//  RootViewController.swift
//  Gobang
//
//  Created by 李招雄 on 2020/8/1.
//  Copyright © 2020 李招雄. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    let splitVC = UISplitViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(splitVC)
        view.addSubview(splitVC.view)
        splitVC.didMove(toParent: self)
        splitVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let masterViewController = MasterViewController(nibName: "MasterViewController", bundle: nil)
        splitVC.viewControllers = [masterViewController]
    }
    
//    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            let orientation = UIDevice.current.orientation
//            if orientation == .landscapeLeft || orientation == .landscapeRight {
//                let tc = UITraitCollection(horizontalSizeClass: .regular)
//                setOverrideTraitCollection(tc, forChild: splitVC)
//            }
//        }
//    }

}
