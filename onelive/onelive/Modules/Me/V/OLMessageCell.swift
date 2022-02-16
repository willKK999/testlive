

import UIKit

class OLMessageCell: UITableViewCell {

    enum MessageStyles {
        case system,
             normal
    }
    
    init(style: MessageStyles) {
        super.init(style: .default, reuseIdentifier: OLSettingCell.description())
        backgroundColor = .white
        imageView?.contentMode = .scaleAspectFit
        imageView?.image = UIImage(named: "icon_msg_bell")
        imageView?.snp.makeConstraints({ make in
            make.left.equalTo(12)
            make.size.equalTo(CGSize(width: 32, height: 32))
            make.centerY.equalToSuperview()
        })
        textLabel?.font = UIFont.fontRegular(14)
        textLabel?.textColor = UIColor(hexString: "#333333")
        switch style {
        case .system:
            textLabel?.snp.makeConstraints({ make in
                make.left.equalTo(imageView!.snp.right).offset(10)
                make.centerY.equalToSuperview()
            })
        case .normal:
            textLabel?.snp.makeConstraints({ make in
                make.top.equalTo(10)
                make.left.equalTo(imageView!.snp.right).offset(10)
                make.height.equalTo(20)
            })
            contentView.addSubview(messageLabel)
            messageLabel.snp.makeConstraints({ make in
                make.top.equalTo(textLabel!.snp.bottom)
                make.left.equalTo(imageView!.snp.right).offset(10)
            })
            contentView.addSubview(dateLabel)
            dateLabel.snp.makeConstraints({ make in
                make.right.equalTo(-12)
                make.centerY.equalToSuperview()
            })
        }
    }
    
    lazy var messageLabel: UILabel =  {
        let label = UILabel()
        label.font = UIFont.fontRegular(10)
        label.textColor = UIColor(hexString: "#999999")
        return label
    }()
    
    lazy var dateLabel: UILabel =  {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .fontRegular(12)
        label.textColor = UIColor(hexString: "#666666")
        label.text = "22:43:21"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
