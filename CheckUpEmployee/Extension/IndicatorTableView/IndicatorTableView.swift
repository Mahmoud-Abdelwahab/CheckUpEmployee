//
//  IndicatorTableView.swift
//  CheckUpEmployee
//
//  Created by Hassan Khamis on 6/11/20.
//  Copyright © 2020 Mahmoud.kasper. All rights reserved.
//

import Foundation
import UIKit
extension UITableView {
    func showActivityIndicator() {
        DispatchQueue.main.async {
//            let activityView = UIActivityIndicatorView(style: .medium)
            let activityView = UIActivityIndicatorView(style: .gray)
            self.backgroundView = activityView
            activityView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            activityView.startAnimating()
        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.backgroundView = nil
        }
    }
}
