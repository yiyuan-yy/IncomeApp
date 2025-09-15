//
//  Fonts.swift
//  IncomeApp
//
//  Created by yiyuan hu on 9/13/25.
//
import SwiftUI

struct Constants {
    struct FontSize {
        static let title = Font.system(size: 30, weight: .heavy)
        static let subtitle = Font.system(size: 20, weight: .bold)
        static let body = Font.system(size: 20, weight: .regular)
        static let addButtonImg =  Font.system(size: 70, weight: .thin)
        static let dollarSign =  Font.system(size:40, weight: .regular)
        static let big =  Font.system(size:50, weight: .regular)
    }
    
    struct ScaleFactor {
        static let textShrink: CGFloat = 0.2
    }
    
    struct Spacing {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
    }
}
