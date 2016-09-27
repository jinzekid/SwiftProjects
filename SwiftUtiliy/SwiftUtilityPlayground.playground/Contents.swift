//: Playground - noun: a place where people can play

import Cocoa

extension String {
    /**
     保存当前字符串
     
     - parameter key: 对应key值
     
     */
    func saveWithKey(key: String) {
        let defatuls = NSUserDefaults.standardUserDefaults()
        defatuls.setObject(self, forKey: key)
        defatuls.synchronize()
    }
    
    /**
     获取当前对应key的String值
     
     - parameter key: 对应key值
     
     - returns: 返回一个带有value和key的元组(value, key)
     */
    func loadTupleValueKey() -> (value: String, key: String){
        let defaults = NSUserDefaults.standardUserDefaults()
        let value = defaults.objectForKey(self) as! String
        return (value, self)
    }
}

let testStr = "";
if testStr.isEmpty {
    print("str is empty")
}

let bbb = "aaaa"
let key = "bbb"
bbb.saveWithKey(key);

let result = key.loadTupleValueKey()
print(result.value + "," + result.key)

//var fridgeIsOpen = false
//let fridgeContent = ["milk", "eggs", "leftovers"]
//
//func fridgeContains(food: String) -> Bool {
//    fridgeIsOpen = true
//    defer {
//        fridgeIsOpen = false
//    }
//    
//    let result = fridgeContent.contains(food)
//    return result
//}
//fridgeContains("banana")
//print(fridgeIsOpen)
//
//
//var str = "Hello, playground"
//
//let fileManager = NSFileManager.defaultManager()
//if let tmpURL = try? fileManager.URLForDirectory(.CachesDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true) {
//    print(tmpURL)
//}
//
//func saveNotification(key: String , value: String) {
//    let defatuls = NSUserDefaults.standardUserDefaults()
//    defatuls.setObject(value, forKey: key)
//    defatuls.synchronize()
//}
//
//func loadNotification(key: String) -> AnyObject? {
//    let defaults = NSUserDefaults.standardUserDefaults()
//    let value = defaults.objectForKey(key)
//    return value
//}
//
//let key = "test"
//saveNotification(key, value: "111")
//
//func checkObjIsNull(object: AnyObject?) -> Bool {
//    if object == nil {
//        return true
//    }
//    return false
//}
//let key2 = "test"
//let value = loadNotification(key2)
//if checkObjIsNull(value) {
//    print("value is nil")
//}
//else {
//    print("value is: \(value)")
//}
//
//
//func fileCahesPath(name: String) -> String {
//    let paths: Array = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)
//    let documentsDirectory = paths[0]
//    return "\(documentsDirectory)/\(name)"
//}
//
//let filePath = fileCahesPath("test.png")
//print(filePath)
//
//
//
//func generateRandomNumber() -> Double {
//    return 0.1
//}
//
//func padString(string: String, length: Int) -> String {
//    return ""
//}
//
//// m
//func twoDigitNumber(number: Int) -> Void {
//    print(String(format: "%02d",number))
//}
//
//twoDigitNumber(102)
//
//var logger: (Int) -> () = twoDigitNumber
//logger(100)
//
//
////func checkAreEqual<T: Equatable>(value: T, expected: T, message: String) {
////    if expected != value {
////        print(message)
////    }
////}
////
////checkAreEqual("test", expected: "tes", message: "not equal")
////checkAreEqual(32, expected: 32.333, message: "not equal")
//
//func square(inout number: Double) {
//    number = number * number
//}
//var ab = 2.0
//square(&ab)
//print(ab)
//
//class Person {
//    var age = 34 , name = "Colin"
//    
//    func growOlder () {
//        self.age++
//    }
//}
//
//func celebrateBirthday(inout cumpleañero: Person) {
////    cumpleañero = Person()
//    print("Happy Birthday \(cumpleañero.name)")
//    cumpleañero.growOlder()
//    
//}
//
//var person = Person()
//celebrateBirthday(&person)
//print(person.age)
//
//func countElements(word: String) -> NSInteger {
//    return word.characters.count
//}
//func longestWord(words: String ...) -> String? {
//    var currentLongest: String?
//    for word in words {
//        if currentLongest != nil {
//            if countElements(word) > countElements(currentLongest!) {
//                currentLongest = word
//            }
//        }
//        else {
//            currentLongest = word
//        }
//    }
//    return currentLongest
//}
//
//let long = longestWord("chick" , "fish" , "cat" , "elephant")
//print(long)

//func checkAreEqual(value: String , expected: String , message: String) {
//    if expected != value {
//        print(message)
//    }
//    
//}
//checkAreEqual("dog", expected: "cat", message: "Incorrect input")

//func checkAreEqual(value val: String , expected exp: String , message msg: String) {
//    if exp != val {
//        print(msg)
//    }
//}
//checkAreEqual(value: "10", expected: "20", message: "not equal")



// MARK: 计算label的高度
//func contentSize(font: UIFont , content: String , bound:CGSize , lineBreakMode:NSLineBreakMode) -> CGSize {
//    
//    //     let options = NSStringDrawingOptions.UsesLineFragmentOrigin.rawValue | NSStringDrawingOptions.UsesFontLeading.rawValue
//    //    let options : NSStringDrawingOptions = .UsesLineFragmentOrigin.rawValue | .UsesFontLeading.rawValue
//    
//    //    let options: NSStringDrawingOptions = .UsesLineFragmentOrigin | .UsesFontLeading
//    let paragraphStyle = NSMutableParagraphStyle()
//    paragraphStyle.lineBreakMode = lineBreakMode//.ByCharWrapping//lineBreakMode;//
//    
//    let attributes = [NSFontAttributeName:font,
//        NSParagraphStyleAttributeName:paragraphStyle.copy()]
//    let boundingRect = content.boundingRectWithSize(bound, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes:attributes, context:nil)
//    
//    return boundingRect.size
//}


//let dictionary = ["firstName":"Mango","lastName":"Fang"]
//for (key, value) in dictionary {
//    print(key + " " + value)
//}
//
//
//class Task {
//    var text: String
//    var completed: Bool = false
//    
//    init(text: String) {
//        self.text = text
//    }
//}
//
//class ToDoListController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
//    var tasks: [Task] = []
//}
//
//struct Beer {
//    var percentRemaining = 100
//    var isEmpty: Bool { return percentRemaining <= 0 }
//    
//    mutating func sip() {
//        guard percentRemaining > 0 else {
//            print("Your beer is empty, order another!")
//            return
//        }
//        
//        percentRemaining -= 10
//        print("Mmmm \(percentRemaining)% left")
//    }
//}
//
//
//
//enum Suit {
//    case Heart
//    case Club
//    case Diamond
//    case Spade
//}

//enum Shape {
//    case Rectangle
//    case Square
//    case Triangle
//    case Circle
//}
//enum Shape: Int {
//    case Rectangle
//    case Square
//    case Triangle
//    case Circle = 10
//}

//var aShape = Shape.Triangle
//var sShape : Shape = .Triangle
//sShape = .Circle

//var triangle = Shape.Triangle
//triangle.rawValue

//var square = Shape(rawValue: 2)
//print(square)
//if square == Shape.Triangle {
//    print("square == Shape")
//} else {
//    print("not square shape")
//}

//enum StringShape: String {
//    case Rectangle = "Rectangle"
//}
//
//var aShape = Shape.Rectangle
//switch(aShape) {
//case .Triangle , .Square:
//    print("This is a rectangle")
//default:
//    print("noknow")
//}

//enum Shape {
//    case Rectangle(width: Float , height: Float)
//    case Square(side: Float)
//    case Triangle(base: Float , height: Float)
//    case Circle(raduis: Float)
//    
//    func area() -> Float {
//        switch(self) {
//        case .Rectangle(let width , let height):
//            return width * height
//        case .Square(let side):
//            return side * side
//        case .Triangle(let base , let height):
//            return 0.5 * base * height
//        case .Circle(let radius):
//            return Float(M_PI) * powf(radius , 2)
//        }
//    }
//    
////    init(_ rect: CGRect) { //_ 初始化写法不一样
////        let width = Float(CGRectGetWidth(rect))
////        let height = Float(CGRectGetHeight(rect))
////        if width == height {
////            self = Square(side: width)
////        } else {
////            self = Rectangle(width: width, height: height)
////        }
////    }
//    
//    
//    static func fromString(string: String) -> Shape? {
//        switch (string) {
//            case "rectangle":
//            return Rectangle(width: 5, height: 10)
//            case "square":
//            return Square(side: 5)
//            case "triangle":
//            return Triangle(base: 5, height: 10)
//            case "circle":
//            return Circle(raduis: 5)
//        default:
//            return nil
//        }
//    }
//}
//var circle = Shape.Circle(raduis: 5)
//circle.area()
////var  shape = Shape(rect: CGRectMake(0, 0, 5, 10))
////var shape = Shape(CGRectMake(0, 0, 5, 20))
//if let shape: Shape = Shape.fromString("") {
//    shape.area()
//}



//var rectangle = Shape.Rectangle(width: 10, height: 10)
//print(rectangle)
//switch(rectangle) {
//case .Rectangle(let width , let height) where width == height:
//    print("Square: \(width) x \(height)")
//case .Rectangle(let width , let height) where width <= 10:
//    print("Narrow rectangle: \(width) x \(height)")
//case .Rectangle(let width , let height):
//    print("Rectangle: \(width) x \(height)")
//default:
//    print("Other shape")
//}


// 结构体还可以实现协议
/*
* Copyright (c) 2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

// Inspired by https://github.com/lingoer/SwiftyJSON

import Foundation

//enum JSONValue {
//    
//    case JSONObject([String:JSONValue])
//    case JSONArray([JSONValue])
//    case JSONString(String)
//    case JSONNumber(NSNumber)
//    case JSONBool(Bool)
//    case JSONNull
//    
//    var object: [String:JSONValue]? {
//        switch self {
//        case .JSONObject(let value):
//            return value
//        default:
//            return nil
//        }
//    }
//    
//    var array: [JSONValue]? {
//        switch self {
//        case .JSONArray(let value):
//            return value
//        default:
//            return nil
//        }
//    }
//    
//    var string: String? {
//        switch self {
//        case .JSONString(let value):
//            return value
//        default:
//            return nil
//        }
//    }
//    
//    var integer: Int? {
//        switch self {
//        case .JSONNumber(let value):
//            return value.integerValue
//        default:
//            return nil
//        }
//    }
//    
//    var double: Double? {
//        switch self {
//        case .JSONNumber(let value):
//            return value.doubleValue
//        default:
//            return nil
//        }
//    }
//    
//    var bool: Bool? {
//        switch self {
//        case .JSONBool(let value):
//            return value
//        case .JSONNumber(let value):
//            return value.boolValue
//        default:
//            return nil
//        }
//    }
//    
//    subscript(i: Int) -> JSONValue? {
//        get {
//            switch self {
//            case .JSONArray(let value):
//                return value[i]
//            default:
//                return nil
//            }
//        }
//    }
//    
//    subscript(key: String) -> JSONValue? {
//        get {
//            switch self {
//            case .JSONObject(let value):
//                return value[key]
//            default:
//                return nil
//            }
//        }
//    }
//    
//    static func fromObject(object: AnyObject) -> JSONValue? {
//        switch object {
//        case let value as NSString:
//            return JSONValue.JSONString(value as String)
//        case let value as NSNumber:
//            return JSONValue.JSONNumber(value)
//        case let value as NSNull:
//            return JSONValue.JSONNull
//        case let value as NSDictionary:
////            var jsonObject: [String:JSONValue] = [:]
//            var jsonObject = [String:JSONValue]()
//            for (k: AnyObject,v: AnyObject) in value {
//                if let k = k as? NSString {
//                    if let v = JSONValue.fromObject(v) {
//                        jsonObject[k] = v
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return JSONValue.JSONObject(jsonObject)
//        case let value as NSArray:
//            var jsonArray: [JSONValue] = []
//            for v in value {
//                if let v = JSONValue.fromObject(v) {
//                    jsonArray.append(v)
//                } else {
//                    return nil
//                }
//            }
//            return JSONValue.JSONArray(jsonArray)
//        default:
//            return nil
//        }
//    }
//}


let json = "{\"success\":true,\"data\":{\"numbers\":[1,2,3,4,5],\"animal\":\" dog\"}}"
//if let jsonData = (json as NSString).dataUsingEncoding(NSUTF8StringEncoding) {
//    let parsed: AnyObject? = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments)
//    
//    if let parsed = parsed as? [String : AnyObject] {
//        if let success = parsed["success"] as? NSNumber {
//            if success.boolValue == true {
//                if let data = parsed["data"] as? NSDictionary {
//                    if let numbers = data["numbers"] as? NSArray {
//                        print(numbers)
//                        print("first number is \(numbers[0])")
//                    }
//                    if let animal = data["animal"] as? NSString {
//                        print(animal)
//                    }
//                }
//            }
//        }
//    }
//}

//if let jsonData = (json as NSString).dataUsingEncoding(NSUTF8StringEncoding) {
//    if let parsed: AnyObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.AllowFragments) {
//        if let jsonParsed = JSONValue.fromObject(parsed) {
//            if jsonParsed["success"]?.bool == true {
//                if let numbers = jsonParsed["data"]?["numbers"]?.array {
//                    print(numbers)
//                }
//                if let animal = jsonParsed["animal"]?.string {
//                    print(animal)
//                }
//            }
//        }
//    }
//}

//var events:[Int] = []






