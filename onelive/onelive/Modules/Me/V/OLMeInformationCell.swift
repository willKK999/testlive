

import UIKit

class OLMeInformationCell: UITableViewCell {

    enum InfoStyles {
        case title,
             copy,
             system
        
    }
    
    init(style: InfoStyles) {
        super.init(style: .default, reuseIdentifier: OLMeInformationCell.description())
        selectionStyle = .none
        switch style {
        case .title:
            textLabel?.font = UIFont.fontMedium(14)
            textLabel?.textColor = UIColor(hexString: "#333333")
            textLabel?.snp.makeConstraints({ make in
                make.left.equalTo(12)
                make.centerY.equalToSuperview()
            })
        case .copy:
            textLabel?.font = UIFont.fontRegular(13)
            textLabel?.textColor = UIColor(hexString: "#333333")
            textLabel?.snp.makeConstraints({ make in
                make.left.equalTo(imageView!.snp.right).offset(5)
                make.centerY.equalToSuperview()
            })
            contentView.addSubview(copyButton)
            copyButton.snp.makeConstraints({ make in
                make.left.equalTo(textLabel!.snp.right).offset(5)
                make.centerY.equalToSuperview()
                make.size.equalTo(CGSize(width: 35, height: 16))
            })
        case .system:
            textLabel?.font = UIFont.fontRegular(13)
            textLabel?.textColor = UIColor(hexString: "#333333")
            textLabel?.snp.makeConstraints({ make in
                make.left.equalTo(imageView!.snp.right).offset(5)
                make.centerY.equalToSuperview()
            })
        }
        imageView?.contentMode = .scaleAspectFit
        imageView?.snp.makeConstraints({ make in
            make.left.equalTo(15)
            make.size.equalTo(CGSize(width: 18, height: 18))
            make.centerY.equalToSuperview()
        })
    }
    
    lazy var copyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("复制", for: .normal)
        button.setTitleColor(UIColor(hexString: "#FF54A8"), for: .normal)
        button.titleLabel?.font = .fontRegular(9)
        button.setLayerCorner(radius: 5,width: 1,color: UIColor(hexString: "#FF54A8").cgColor)
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
