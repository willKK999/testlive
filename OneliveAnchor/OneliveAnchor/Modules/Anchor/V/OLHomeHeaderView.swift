

import UIKit

class OLHomeHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.height.equalTo(180)
        }
        
        bgImageView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(26)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        bgImageView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
        
        bgImageView.addSubview(timeTitleLabel)
        timeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(22)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var bgImageView: UIImageView = {
         let imageView = UIImageView()
        imageView.image = OLImage.icon_anchor_bg
         return imageView
    }()
    
    lazy var titleLabel: UILabel =  {
        let label = UILabel()
        label.font = OLFont.PingFang_Medium14
        label.textColor = OLColors.hex_FFFFFF
        label.text = "- 今日（全球）-"
        return label
    }()
    
    lazy var timeLabel: UILabel =  {
        let label = UILabel()
        label.font = OLFont.PingFang_Medium22
        label.textColor = OLColors.hex_FFFFFF
        label.text = "00:00:00"
        return label
    }()
    
    lazy var timeTitleLabel: UILabel =  {
        let label = UILabel()
        label.font = OLFont.PingFang_Regular16
        label.textColor = OLColors.hex_FFFFFF
        label.text = "直播时长"
        return label
    }()

}
