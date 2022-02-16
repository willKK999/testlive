

import UIKit

class OLGuardianInstructionsController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "守护说明"
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: oScreenHeight))
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = UIColor(hexString: "#FF64D7")
        let bgImageView  = UIImageView(image: UIImage(named: "image_bg_instructions"))
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.width.equalTo(oScreenWidth)
            make.top.bottom.equalToSuperview()
        }
        let imageView  = UIImageView(image: UIImage(named: "icon_guardian"))
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(65)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 110, height: 100))
        }
        view.addSubview(guardianView)
        guardianView.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(50)
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.height.equalTo(110)
        }
        view.addSubview(guardianTypeView)
        guardianTypeView.snp.makeConstraints { (make) in
            make.top.equalTo(guardianView.snp.bottom).offset(10)
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.height.equalTo(245)
        }
        let view3 = UIView()
        view3.backgroundColor = .white
        view3.setLayerCorner(radius: 12)
        view.addSubview(view3)
        view3.snp.makeConstraints { (make) in
            make.top.equalTo(guardianTypeView.snp.bottom).offset(10)
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.height.equalTo(435)
        }
        let view4 = UIView()
        view4.backgroundColor = .white
        view4.setLayerCorner(radius: 12)
        view.addSubview(view4)
        view4.snp.makeConstraints { (make) in
            make.top.equalTo(view3.snp.bottom).offset(10)
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.height.equalTo(245)
        }
        let view5 = UIView()
        view5.backgroundColor = .white
        view5.setLayerCorner(radius: 12)
        view.addSubview(view5)
        view5.snp.makeConstraints { (make) in
            make.top.equalTo(view4.snp.bottom).offset(10)
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.height.equalTo(145)
        }
        let view6 = UIView()
        view6.backgroundColor = .white
        view6.setLayerCorner(radius: 12)
        view.addSubview(view6)
        view6.snp.makeConstraints { (make) in
            make.top.equalTo(view5.snp.bottom).offset(10)
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.height.equalTo(165)
        }
        view.contentSize = CGSize(width: oScreenWidth, height: view6.bottom + 30)
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame:CGRect(x: 0, y: 0, width: 120, height: 28))
        label.addGradient([UIColor(hexString: "#FF54EE").cgColor,UIColor(hexString: "#FFD7B9").cgColor], startPoint: CGPoint(x: -0.05, y: 0.13), endPoint: CGPoint(x: 0.95, y: 0.13))
        label.setLayerCorner(radius: 14)
        label.bottomBorder(width: 1, borderColor: UIColor(hexString: "#F553D8"))
        label.font = UIFont.fontRegular(14)
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.textAlignment = .center
        return label
    }()
    
    lazy var guardianView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.setLayerCorner(radius: 12)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 120, height: 28))
        }
        titleLabel.text = "什么是守护"
        return view
    }()
    
    lazy var guardianTypeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.setLayerCorner(radius: 12)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 120, height: 28))
        }
        titleLabel.text = "守护类型"
        return view
    }()
}
