
import UIKit

class OLNavBarTitleCell: UICollectionViewCell {
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
        titleLabel.font = .fontRegular(18)
        titleLabel.textColor = UIColor(hexString: "#666666")
        titleLabel.text = "热门"
        return titleLabel
    }()

    func setSelected(_ selected: Bool) {
        if selected {
            titleLabel.font = .fontMedium(18)
            titleLabel.textColor = UIColor(hexString: "#333333")
        } else {
            titleLabel.font = .fontRegular(18)
            titleLabel.textColor = UIColor(hexString: "#666666")
        }
    }
}
