

import UIKit
import SDCycleScrollView

class OLLiveBannerView: UICollectionReusableView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bannerView)
        bannerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(90)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var bannerView: SDCycleScrollView = {
        let cycleScrollView = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: oScreenWidth - 24, height: 90), imageNamesGroup: ["banner0", "banner0", "banner0"])
        cycleScrollView!.backgroundColor = UIColor(red: 216 / 255.0, green: 216 / 255.0, blue: 216 / 255.0, alpha: 1.00)
        cycleScrollView!.layer.cornerRadius = 5
        cycleScrollView!.layer.masksToBounds = true
        return cycleScrollView!
    }()

}
