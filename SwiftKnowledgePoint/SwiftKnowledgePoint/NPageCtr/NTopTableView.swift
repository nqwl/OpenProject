//
//  NTopTableView.swift
//  SwiftKnowledgePoint
//
//  Created by 陈辉 on 2019/11/13.
//  Copyright © 2019 Nqwl. All rights reserved.
//

import UIKit

class NTopTableView: UITableView,UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) && otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.self)
    }
}
