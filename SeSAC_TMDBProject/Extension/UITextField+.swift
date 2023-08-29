//
//  UITextField+.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/30.
//

import UIKit

extension UITextField {

    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }

}
