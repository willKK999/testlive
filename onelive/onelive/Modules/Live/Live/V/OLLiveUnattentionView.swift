
import UIKit

class OLLiveUnattentionView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(120)
            make.width.equalTo(120)
            make.height.equalTo(124)
        }
        addSubview(unattensionLabel)
        unattensionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(13)
            make.height.equalTo(22)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "live_unattention")
        return imageView
   }()
    
    lazy var unattensionLabel: UILabel = {
        let  unattensionLabel = UILabel()
        unattensionLabel.textAlignment = .center
        unattensionLabel.font = .fontRegular(16)
        unattensionLabel.textColor = UIColor(hexString: "#666666")
        unattensionLabel.text = "暂无关注"
        return unattensionLabel
    }()
    
}

