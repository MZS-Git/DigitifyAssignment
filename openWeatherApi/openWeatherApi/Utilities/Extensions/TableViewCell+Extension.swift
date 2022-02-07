//
//  TableViewCell+Extension.swift
//  openWeatherApi
//
//  Created by Muhammad Zain Shahid on 07/02/2022.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    static func identifier() -> String {
        return String(describing: self)
    }
}
