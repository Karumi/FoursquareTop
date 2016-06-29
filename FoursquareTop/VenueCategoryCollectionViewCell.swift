
import UIKit

let VenueCategoryCollectionViewCellReuseIdentifier = "VenueCategoryCollectionViewCellReuseIdentifier" 

class VenueCategoryCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet private weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        label.font = UIFont.regularBold
        backgroundColor = UIColor.ftopBlue
    }
    
    func configureWithCategory(category: VenueCategoryViewModel) {
        self.label.text = category.names.get(forType: .Regular)
    }
}
