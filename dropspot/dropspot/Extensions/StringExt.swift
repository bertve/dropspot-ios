//
//  StringExt.swift
//  dropspot
//
//  Created by Bert Van eeckhoutte on 03/01/2021.
//

import Foundation

extension String {
    func trim() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
