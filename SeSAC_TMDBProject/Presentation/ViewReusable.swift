//
//  ViewReusable.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/12.
//

import UIKit

protocol ViewReusable: AnyObject {
    static var identifier: String { get }
}


extension UICollectionViewCell: ViewReusable {
    static var identifier: String { return String(describing: self) }
}
