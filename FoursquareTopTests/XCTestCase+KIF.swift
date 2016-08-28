import Foundation
import KIF

public extension XCTestCase {
    
    public func kifTester(file : String = #file, line : Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
    
    public func kifSystem(file : String = #file, line : Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}
