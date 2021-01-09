//
//  FloatExt.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 09/01/2021.
//

import Foundation

extension Float {
    func formatAsEuroCurrency() -> String? {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencyCode = "EUR"
        currencyFormatter.maximumFractionDigits = floor(self) == self ? 0 : 2
        return currencyFormatter.string(from: NSNumber(value: self))
    }
}
