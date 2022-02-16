
import UIKit

class OLRecommendedView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleButton)
        titleButton.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(18)
        }
        
        addSubview(liveButton)
        liveButton.snp.makeConstraints { (make) in
            make.top.equalTo(titleButton.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-12)
            make.size.equalTo(CGSize(width: 38.0, height: 38.0))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var titleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 68, height: 18)
        button.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.20)
        let maskPath = UIBezierPath(roundedRect: button.bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: 9, height: 9))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = button.bounds
        maskLayer.path = maskPath.cgPath
        button.layer.mask = maskLayer
        //arrow
        let arrowView = UIImageView(image: UIImage(named: "arrow_left_w"))
        button.addSubview(arrowView)
        arrowView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(2)
            make.size.equalTo(CGSize(width: 12, height: 12))
        }
        let label = UILabel()
        label.text = "为你推荐"
        label.textColor = UIColor.white
        label.font = UIFont.fontRegular(9)
        button.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(arrowView.snp.right)
        }
        return button
    }()
    
    lazy var liveButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 38, height: 38)
        button.setBackgroundImage(UIImage(named: "live_placeholder"), for: .normal)
        button.setLayerCorner(radius: 3)
        return button
    }()
}
