

import UIKit

class OLLiveFollowHeaderView: UICollectionReusableView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right).offset(5)
            make.centerY.equalToSuperview()
            make.height.equalTo(18)
        }
        addSubview(changeButton)
        changeButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
            make.width.equalTo(58)
            make.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        return imageView
   }()
    
    lazy var titleLabel: UILabel = {
        let  label = UILabel()
        label.textAlignment = .center
        label.font = .fontMedium(13)
        label.textColor = UIColor(red: 51 / 255.0, green: 51 / 255.0, blue: 51 / 255.0, alpha: 1.00)
        return label
    }()
    
    lazy var changeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 58, height: 20)
        button.setTitle("换一批", for: .normal)
        button.setTitleColor(UIColor(red: 255 / 255.0, green: 84 / 255.0, blue: 168 / 255.0, alpha: 1.00), for: .normal)
        button.titleLabel?.font = .fontSemibold(13)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 255 / 255.0, green: 84 / 255.0, blue: 168 / 255.0, alpha: 1.00).cgColor
        button.layer.cornerRadius = 5
        button.isHidden = true
        return button
    }()
}
