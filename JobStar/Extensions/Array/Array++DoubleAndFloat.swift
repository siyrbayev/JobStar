//
//  Array++Double.swift
//  JobStar
//
//  Created by siyrbayev on 26.05.2022.
//

import Foundation

extension Array where Element == Double? {
    
    /// Returns a new string by concatenating the elements of the sequence,
    /// adding the given separator between each NOT empty and NOT nil element.
    ///
    /// The following example shows how an array of optianl doubles can be joined to a
    /// single, comma-separated string:
    ///
    ///     let array: [Double?] = [0, 100]
    ///     let list = array.joined(separator: "_")
    ///     print(list)
    ///     // Prints "100"
    ///
    /// - Parameter separator: A string to insert between each of the elements
    ///   in this sequence. The default separator is an empty string.
    /// - Returns: A single, concatenated string.
    public func joined(separator: String = "", replacement: String = "") -> String {
        let string: String = self.compactMap { ($0?.isZero ?? true) ? nil : $0 }.joined(separator: separator)
        return string.isEmpty ? replacement : string
    }
}
