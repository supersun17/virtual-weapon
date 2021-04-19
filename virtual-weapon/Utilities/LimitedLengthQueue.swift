//
//  LimitedLengthQueue.swift
//  virtual-weapon
//
//  Created by Ming Sun on 4/9/21.
//

import Foundation



struct LimitedLengthQueue<T: Any> {
    private var items: [T] = []
    private var overridingIndex: Int = 0
    var length: Int = 1 {
        didSet {
            reform()
        }
    }

    init(length lth: Int) {
        length = lth
    }

    mutating func view() -> [T] {
        reform()
        return items
    }

    mutating func push(item: T) {
        switch items.count {
        case length...:
            override(with: item)
        default:
            items.append(item)
        }
    }

    mutating func pop() -> T? {
        guard !items.isEmpty else { return nil }
        reform()
        return items.removeLast()
    }
}



private extension LimitedLengthQueue {
    private mutating func override(with item: T) {
        switch overridingIndex {
        case length...:
            overridingIndex = 0
            override(with: item)
        default:
            items[overridingIndex] = item
            overridingIndex += 1
        }
    }

    private mutating func reform() {
        switch overridingIndex {
        case 1...:
            for i in 0..<overridingIndex {
                items.append(items[i])
            }
            items.removeFirst(overridingIndex)
        default:
            break
        }
        overridingIndex = 0
    }
}
