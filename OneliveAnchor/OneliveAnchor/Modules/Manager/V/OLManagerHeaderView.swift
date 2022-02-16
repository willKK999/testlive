

import UIKit

class OLManagerHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.left.equalTo(12)
            make.right.equalTo(-12)
            make.height.equalTo(180)
        }
        
        bgImageView.addSubview(totalTitleLabel)
        totalTitleLabel.snp.makeConstraints { make in
            make.top.left.equalTo(20)
            make.height.equalTo(22)
        }
        bgImageView.addSubview(totalAmountLabel)
        totalAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(45)
            make.left.equalTo(20)
            make.height.equalTo(22)
        }
        
        bgImageView.addSubview(horizontalLine)
        horizontalLine.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        bgImageView.addSubview(todayTitleLabel)
        todayTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalLine.snp.bottom).offset(20)
            make.left.equalTo(20)
            make.height.equalTo(22)
        }
        bgImageView.addSubview(todayAmountLabel)
        todayAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalLine.snp.bottom).offset(45)
            make.left.equalTo(20)
            make.height.equalTo(22)
        }
        
        bgImageView.addSubview(verticalLine)
        verticalLine.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-30)
            make.width.equalTo(1)
            make.height.equalTo(40)
        }
        
        bgImageView.addSubview(monthTitleLabel)
        monthTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalLine.snp.bottom).offset(20)
            make.right.equalTo(-20)
            make.height.equalTo(22)
        }
        bgImageView.addSubview(monthAmountLabel)
        monthAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalLine.snp.bottom).offset(45)
            make.left.equalTo(monthTitleLabel.snp.left)
            make.height.equalTo(22)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var bgImageView: UIImageView = {
         let imageView = UIImageView()
        imageView.image = OLImage.icon_manager_bg
         return imageView
    }()
    
    lazy var horizontalLine: UIImageView = {
         let imageView = UIImageView()
        imageView.image = OLImage.manager_line_horizontal
         return imageView
    }()
    
    lazy var verticalLine: UIImageView = {
         let imageView = UIImageView()
        imageView.image = OLImage.manager_line_vertical
         return imageView
    }()
    
    lazy var totalTitleLabel: UILabel =  {
        let label = UILabel()
        label.font = OLFont.PingFang_Regular16
        label.textColor = OLColors.hex_FFFFFF
        label.text = "总资产（USD）"
        return label
    }()
    
    lazy var totalAmountLabel: UILabel =  {
        let label = UILabel()
        label.font = OLFont.PingFang_Medium18
        label.textColor = OLColors.hex_FFD843
        label.text = "10000.00"
        return label
    }()
    
    lazy var todayTitleLabel: UILabel =  {
        let label = UILabel()
        label.font = OLFont.PingFang_Regular16
        label.textColor = OLColors.hex_FFFFFF
        label.text = "今日收入（USD）"
        return label
    }()
    
    lazy var todayAmountLabel: UILabel =  {
        let label = UILabel()
        label.font = OLFont.PingFang_Medium16
        label.textColor = OLColors.hex_FFD843
        label.text = "0.00"
        return label
    }()
    
    lazy var monthTitleLabel: UILabel =  {
        let label = UILabel()
        label.font = OLFont.PingFang_Regular16
        label.textColor = OLColors.hex_FFFFFF
        label.text = "本月收入（USD）"
        return label
    }()
    
    lazy var monthAmountLabel: UILabel =  {
        let label = UILabel()
        label.font = OLFont.PingFang_Medium16
        label.textColor = OLColors.hex_FFD843
        label.text = "0.00"
        return label
    }()
}
