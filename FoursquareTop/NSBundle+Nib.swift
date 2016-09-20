
import UIKit

extension NSBundle {
    public func loadNib<T: UIView>(name name: String, owner: AnyObject?) -> T {
        return self.loadNibNamed(name, owner: owner, options: nil)![0] as! T
    }
    
    public func loadNib<T: UIView>(name name: String) -> T {
        return self.loadNibNamed(name, owner: nil, options: nil)![0] as! T
    }
}
