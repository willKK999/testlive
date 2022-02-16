

import UIKit

class OLForDiamondCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayerCorner(radius: 2,width: 1,color: UIColor(hexString: "#FF54A8").cgColor)
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(13)
            make.centerX.equalToSuperview()
        }
        
        contentView.addSubview(moneyLabel)
        moneyLabel.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(36)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel =  {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = .fontMedium(14)
        titleLabel.textColor = UIColor(hexString: "#FF54A8")
        titleLabel.text = "233钻"
        return titleLabel
    }()
    
    lazy var moneyLabel: UILabel =  {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.width, height: 36))
        titleLabel.textAlignment = .center
        titleLabel.font = .fontMedium(14)
        titleLabel.textColor = UIColor(hexString: "#FFFFFF")
        titleLabel.text = "30元"
        titleLabel.addGradient([UIColor(hexString: "#FF54EE").cgColor,UIColor(hexString: "#FFD7B9").cgColor] , startPoint: CGPoint(x: 0.52,y: 0.71), endPoint: CGPoint(x:0.52, y: 0.00))
        return titleLabel
    }()
}
