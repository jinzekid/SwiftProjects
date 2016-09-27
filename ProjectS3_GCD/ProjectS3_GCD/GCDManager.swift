//
//  GCDManager.swift
//  ProjectS3_GCD
//
//  Created by apple on 6/23/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

import Foundation

let currentThread = Thread.current()
let mainQueue = DispatchQueue.main

func newQueue(name: String, queue: DispatchQueue, attributes: DispatchQueueAttributes) -> DispatchQueue {
    let queue = DispatchQueue.init(label: name, attributes: .qosDefault, target: queue)
    return queue
}

//let aQueue = DispatchQueue.init(label: <#T##String#>)

func newGroupQueue() -> DispatchGroup {
    let group = DispatchGroup.init()
    return group
}
