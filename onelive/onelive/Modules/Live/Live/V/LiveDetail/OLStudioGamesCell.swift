

import UIKit

class OLStudioGamesCell:  UICollectionViewCell {

    var model: OLLotteryGameModel! {
        didSet {
            if let url = URL(string: model.iconUrl) {
                iconImageView.kf.setImage(with: url, placeholder: UIImage(named: "avatar"))
            }
            titleLabel.text = model.name
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(5)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 46, height: 46))
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(10)
            make.left.right.centerX.equalToSuperview()
            make.height.equalTo(12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "live_placeholder"))
        imageView.setLayerCorner(radius: 23)
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let  label = UILabel()
        label.font = UIFont.fontRegular(12)
        label.textColor = UIColor(hexString: "#333333")
        label.textAlignment = .center
        label.text = "快三"
        return label
    }()
}
