

import UIKit
import SwiftUI

class OLLiveShowCell: UICollectionViewCell {
    var model: OLLiveItemModel! {
        didSet {
            if let url = URL(string: model.studioThumbImage ?? "") {
                backgroundImageView.kf.setImage(with: url, placeholder: UIImage(named: "live_placeholder"))
            }
            nameLabel.text = model.studioTitle
            locationLabel.text = model.countryName
            attendanceLabel.text = String(model.viewsNumber ?? 0)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        
        self.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.layer.addSublayer(bgGradientLayer)
        
        self.addSubview(typeBGView)
        typeBGView.snp.makeConstraints { make in
            make.top.equalTo(5)
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 53, height: 17))
        }
        
        addDescribeLabels(["按时收费", "10钻一分钟"])
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(-20)
        }
        
        addSubview(locationImageView)
        locationImageView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.bottom.equalTo(-8)
            make.size.equalTo(CGSize(width: 8, height: 8))
        }
        
        addSubview(locationLabel)
        locationLabel.snp.makeConstraints { make in
            make.left.equalTo(locationImageView.snp.right).offset(2)
            make.bottom.equalTo(-6)
            make.height.equalTo(13)
        }
        
        addSubview(attendanceLabel)
        attendanceLabel.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.bottom.equalTo(-4)
            make.height.equalTo(17)
        }
        
        addSubview(hotImageView)
        hotImageView.snp.makeConstraints { make in
            make.right.equalTo(attendanceLabel.snp.left)
            make.bottom.equalTo(-9)
            make.size.equalTo(CGSize(width: 8, height: 8))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "live_placeholder"))
        return imageView
    }()
    
    lazy var bgGradientLayer: CAGradientLayer = {
        let bgGradientLayer = CAGradientLayer()
        bgGradientLayer.frame = bounds
        bgGradientLayer.startPoint = CGPoint(x: 0.50, y: 0.00)
        bgGradientLayer.endPoint = CGPoint(x: 0.50, y: 1.00)
        bgGradientLayer.colors = [
            UIColor(hexString: "#000000",alpha: 0).cgColor,
            UIColor(hexString: "#000000").cgColor
        ]
        bgGradientLayer.locations = [NSNumber(value: 0), NSNumber(value: 1.0)]
        return bgGradientLayer
    }()
    
    lazy var typeBGView: UIView = {
        let view = UIView(frame:CGRect(x: 0, y: 0, width: 53, height: 17))
        view.roundCorners([.topRight,.bottomRight], radius: 79)
        view.addGradient([UIColor(hexString: "#FF54EE").cgColor,UIColor(hexString: "#FFD7B9").cgColor], locations: [0, 1], startPoint: CGPoint(x: -0.05, y: 0.13), endPoint: CGPoint(x: 0.95, y: 0.13))
        view.addSubview(typeLabel)
        typeLabel.snp.makeConstraints { make in
            make.left.equalTo(2)
            make.top.right.bottom.equalToSuperview()
        }
        return view
    }()
    
    lazy var typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.textAlignment = .left
        typeLabel.font = UIFont.fontRegular(9)
        typeLabel.textColor = UIColor.white
        typeLabel.text = "一分快三"
        return typeLabel
    }()
    
    func addDescribeLabels(_ describes: [String]) {
        for i in 0..<describes.count {
            let desLabel = UILabel()
            desLabel.font = UIFont.fontRegular(6)
            desLabel.text = describes[i]
            desLabel.textColor = UIColor.white
            desLabel.sizeToFit()
            let width = desLabel.frame.size.width + 10
            let height: CGFloat = 11.0
            let bgView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
            bgView.addSubview(desLabel)
            desLabel.snp.makeConstraints { make in
                make.left.equalTo(2)
                make.centerY.equalToSuperview()
                make.size.equalTo(CGSize(width: desLabel.width, height: desLabel.height))
            }
            bgView.backgroundColor = UIColor(hexString: "#000000", alpha: 0.2)
            bgView.roundCorners([.topRight,.bottomRight], radius: 8)
            self.addSubview(bgView)
            bgView.snp.makeConstraints { make in
                make.top.equalTo(typeBGView.snp.bottom).offset(3.0 + (height + 3.0)*CGFloat(i))
                make.left.equalToSuperview()
                make.size.equalTo(CGSize(width: width, height: height))
            }
        }
    }
    
    lazy var locationImageView: UIImageView = {
        let hotImageView = UIImageView(image: UIImage(named: "icon_location"))
        return hotImageView
    } ()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.fontRegular(10)
        label.textColor = UIColor.white
        label.text = "中国"
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.fontRegular(10)
        label.textColor = UIColor.white
        label.text = "主播名字"
        return label
    }()
    
    lazy var attendanceLabel: UILabel = {
        let attendanceLabel = UILabel()
        attendanceLabel.textAlignment = .right
        attendanceLabel.font = UIFont.fontRegular(12)
        attendanceLabel.textColor = UIColor.white
        attendanceLabel.text = "35345"
        return attendanceLabel
    }()
    
    lazy var hotImageView: UIImageView = {
        let hotImageView = UIImageView(image: UIImage(named: "icon_popular"))
        return hotImageView
    } ()
    
    
    
    
}
