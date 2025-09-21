// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public func Log(_ obj: Any? = nil, file: String = #file, function: String = #function, line: Int = #line)  {
    var filename: NSString = file as NSString
    filename = filename.lastPathComponent as NSString

    print("[\(filename) > \(function) \(line)] \(String(describing: obj))")
}
