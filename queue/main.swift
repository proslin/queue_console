//
//  main.swift
//  queue
//
//  Created by Lina Prosvetova on 12.09.2022.
//


import Foundation


struct Queue<T> {
    
    public typealias Element = T
    
    fileprivate var array = [Element?]()
    fileprivate var head = 0
    
    public var isEmpty : Bool {
        return count == 0
    }
    
    public var count: Int {
        return array.count - head
    }
    
    public mutating func enqueue(_ element: Element) {
        array.append(element)
    }
    
    public mutating func dequeue() -> Element? {
        guard head < array.count, let element = array[head] else { return nil }
        array[head] = nil
        head += 1
        
        let percentage = Double(head)/Double(array.count)
        if array.count > 1 && percentage > 0.25 {
            array.removeFirst(head)
            head = 0
        }
        
        return element
    }
    
    public mutating func filter(predicate:(Element) -> Bool) -> Queue<Element> {
        var result = [Element]()
        for i in array {
            if let elem = i, predicate(elem) {
                result.append(elem)
            }
        }
        array = result
        head = 0
        return Queue.init(array: array, head: head)
    }
    
    subscript(_ idx: Int) -> Element? {
        guard (array.startIndex..<array.endIndex).contains(idx) else { return nil }
        return array[idx]
    }
    
}


var queue = Queue<Int>()
queue.enqueue(1)
queue.enqueue(2)
queue.enqueue(3)
queue.enqueue(4)
queue.enqueue(5)
queue.enqueue(8)


print(queue)
var elem = queue.dequeue()
print(queue)
print(type(of: queue))
print(queue[2] ?? "nil")
elem = queue.dequeue()
print(queue)
print(queue[1] ?? "nil")
print(queue[5] ?? "nil")
var filteredB  = Queue<Int>()
let filteredQueue = queue.filter(predicate: { $0 % 2 == 0 })
print(filteredQueue)


