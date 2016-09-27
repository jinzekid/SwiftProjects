//
//  DataManager.swift
//  ProjectS3_CarFinder
//
//  Created by apple on 6/29/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

import Foundation
import CoreLocation

typealias MyType = (String, String, Int)
typealias CompareValueResult = (Bool, Int)

enum PlaybackStates : Int {
    case Failed = -1
    case Loading
    case Success
}
var myPlaybackState = PlaybackStates.Failed
let playbackStateValue: Int = PlaybackStates.Failed.rawValue

enum TranslationError: Int, ErrorProtocol {
    case EmptyString = -100
    case UnrecognizedLanguage = 1000
    case InvalidString = 1001
}

class DataManager {
    static let shareIntance = DataManager()
    var locations: [CLLocation]
    var myVariable: MyType = ("Bob", "Bob is cool", 1)
    var myStatistics: (Int, Int, Float) = (2, 2, 5.2)
    private init() {
        locations = [CLLocation]()
    }
    
    func compare(value1: Int, value2: Int) -> CompareValueResult {
        return (true, 10)
    }
    
    func translate(inputString: String?) throws -> Void {
        guard let string = inputString else { throw TranslationError.EmptyString }
        print("string===\(string)")
    }
    
    
    
}
