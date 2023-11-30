//
//  ExtensionFloat.swift
//  iTomicBudget
//
//  Created by J. DeWeese on 11/30/23.
//

import Foundation

//Mark:  currency float formatter
extension Float {
    func formattedWithSeparatorAndCurrency(roundingNumbers: Bool) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if roundingNumbers == true {
            formatter.maximumFractionDigits = 0
        } else {
            formatter.maximumFractionDigits = 2
        }
        let formattedNumber = formatter.string(from: NSNumber(value: self)) ?? "\(self)"
        return formattedNumber
    }
}
