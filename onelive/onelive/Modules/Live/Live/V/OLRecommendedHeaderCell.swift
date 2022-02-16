


import UIKit
import Kingfisher

class OLRecommendedHeaderCell: UICollectionViewCell {
    
    var model:OLAdvModel! {
        didSet {
            imageView.kf.setImage(with: URL(string: model.advImg ?? ""), placeholder: UIImage(named: "icon_fishing"))
            titleLabel.text = model.advName
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 62, height: 32))
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 62, height: 32))
        imageView.image = UIImage(named: "icon_fishing")
        return imageView
    }()
    
    lazy var titleLabel: UILabel =  {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.fontRegular(12)
        titleLabel.text = "财神"
        titleLabel.textColor = UIColor(red: 102 / 255.0, green: 102 / 255.0, blue: 102 / 255.0, alpha: 1.00)
        return titleLabel
    }()
    
}
