

import UIKit
import SnapKit

class OLLiveTitleCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel =  {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = .fontRegular(14)
        titleLabel.textColor = UIColor(red: 153 / 255.0, green: 153 / 255.0, blue: 153 / 255.0, alpha: 1.00)
        titleLabel.text = "热门"
        return titleLabel
    }()

    func setSelected(_ selected: Bool) {
        if selected {
            titleLabel.font = .fontMedium(14)
            titleLabel.textColor = UIColor(red: 51 / 255.0, green: 51 / 255.0, blue: 51 / 255.0, alpha: 1.00)
        } else {
            titleLabel.font = .fontRegular(14)
            titleLabel.textColor = UIColor(red: 153 / 255.0, green: 153 / 255.0, blue: 153 / 255.0, alpha: 1.00)
        }
    }

}
