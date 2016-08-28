
import UIKit

public extension UICollectionView {
    
    func registerCell(nibName name: String, forCellReuseIdentifier identifier: String, inBundle bundle: NSBundle = NSBundle.mainBundle()) {
        registerNib(
            UINib(nibName: name, bundle: bundle),
            forCellWithReuseIdentifier: identifier
        )
    }
    
    func registerHeader(nibName name: String, withReuseIdentifier identifier: String, inBundle bundle: NSBundle = NSBundle.mainBundle()) {
        registerNib(
            UINib(nibName: name, bundle: bundle),
            forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
            withReuseIdentifier: identifier
        )
    }
    
    func registerFooter(nibName name: String, withReuseIdentifier identifier: String, inBundle bundle: NSBundle = NSBundle.mainBundle()) {
        registerNib(
            UINib(nibName: name, bundle: bundle),
            forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
            withReuseIdentifier: identifier
        )
    }
    
    func dequeueCell<T>(reuseIdentifier reuseIdentifier: String, forIndexPath indexPath: NSIndexPath) -> T {
        return dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! T
    }
    
    func dequeueHeader<T>(reuseIdentifier reuseIdentifier: String, forIndexPath indexPath: NSIndexPath) -> T {
        return dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: reuseIdentifier, forIndexPath: indexPath) as! T
    }
    
    func dequeueFooter<T>(reuseIdentifier reuseIdentifier: String, forIndexPath indexPath: NSIndexPath) -> T {
        return dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: reuseIdentifier, forIndexPath: indexPath) as! T
    }
}