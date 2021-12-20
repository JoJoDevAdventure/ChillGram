//
//  Extensions.swift
//  ChillGram
//
//  Created by Youssef Bhl on 29/11/2021.
//

import Foundation

extension String {
     func safeDatabaseKey() -> String {
        return self.replacingOccurrences(of: "@", with: "-").replacingOccurrences(of: ".", with: "-")
    }
}
