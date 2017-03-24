//
//  Utilities.swift
//  TimeSlowerDataBase
//
//  Created by Alex Shcherbakov on 3/23/17.
//  Copyright © 2017 Alex Shcherbakov. All rights reserved.
//

import Foundation

extension Sequence where Iterator.Element: AnyObject {
    public func containsObjectIdentical(to object: AnyObject) -> Bool {
        return contains { $0 === object }
    }
}


extension Array {
    var decomposed: (Iterator.Element, [Iterator.Element])? {
        guard let x = first else { return nil }
        return (x, Array(self[1..<count]))
    }

    func sliced(size: Int) -> [[Iterator.Element]] {
        var result: [[Iterator.Element]] = []
        for idx in stride(from: startIndex, to: endIndex, by: size) {
            let end = Swift.min(idx + size, endIndex)
            result.append(Array(self[idx..<end]))
        }
        return result
    }
}


extension URL {
    static var temporary: URL {
        return URL(fileURLWithPath:NSTemporaryDirectory(), isDirectory: true).appendingPathComponent(UUID().uuidString)
    }

    static var documents: URL {
        return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
}


extension String {
    public func removingCharacters(in set: CharacterSet) -> String {
        var chars = characters
        for idx in chars.indices.reversed() {
            if set.contains(String(chars[idx]).unicodeScalars.first!) {
                chars.remove(at: idx)
            }
        }
        return String(chars)
    }
}
