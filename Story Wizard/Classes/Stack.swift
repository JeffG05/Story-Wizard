//
//  Stack.swift
//  Story Wizard
//
//  Created by jack rathbone on 24/10/2022.
//

import Foundation

class Stack<Element> {
    private var items: [Element]
    private var topPointer : Int
    
    init() {
        items = []
        topPointer = -1
    }
    func push(item: Element) {
        items.append(item)
        topPointer += 1
    }
    func pop() -> Element? {
        if topPointer != -1 {
            let result = items[topPointer]
            items.remove(at: topPointer)
            topPointer -= 1
            return result
        } else {
            return nil
        }
    }
    func peek() -> Element? {
        if topPointer != -1 {
            return items[topPointer]
        } else {
            return nil
        }
    }
}
