
// http://stackoverflow.com/a/28075467/802118
import Foundation

public extension Int {
    /// Returns a random Int point number between 0 and Int.max.
    public static var random:Int {
        get {
            return Int.random(Int.max)
        }
    }
    /**
     Random integer between 0 and n-1.
     
     - parameter n: Int
     
     - returns: Int
     */
    public static func random(n: Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }
    /**
     Random integer between min and max
     
     - parameter min: Int
     - parameter max: Int
     
     - returns: Int
     */
    public static func random(min: Int, max: Int) -> Int {
        return Int.random(max - min + 1) + min
        //Int(arc4random_uniform(UInt32(max - min + 1))) + min }
    }
}