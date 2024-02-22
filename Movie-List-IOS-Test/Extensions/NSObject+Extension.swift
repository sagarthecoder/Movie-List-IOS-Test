//
//  NSObject+Extension.swift
//  Movie-List-IOS-Test
//
//  Created by Sagar on 2/23/24.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: self)
    }
    
    public class var className: String {
        return String(describing: self)
    }
}
