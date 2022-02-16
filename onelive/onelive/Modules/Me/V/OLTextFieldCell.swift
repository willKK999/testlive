

import UIKit

class OLTextFieldCell: UITableViewCell {
    
    enum InputStyles {
        case phone,
             code,
             text
    }
    
    
    init(style: InputStyles) {
        super.init(style: .default, reuseIdentifier: OLTextFieldCell.description())
        textLabel?.font = UIFont.fontRegular(16)
        textLabel?.textColor = UIColor(hexString: "#333333")
        textLabel?.snp.makeConstraints({ make in
            make.left.equalTo(12)
            make.centerY.equalToSuperview()
        })
        contentView.addSubview(textField)
        switch style {
        case .phone:
            textField.placeholder = "请输入手机号码"
            contentView.addSubview(sendButton)
            sendButton.snp.makeConstraints({ make in
                make.right.equalTo(-12)
                make.centerY.equalToSuperview()
                make.size.equalTo(CGSize(width: 80, height: 26))
            })
            textField.snp.makeConstraints({ make in
                make.left.equalTo(textLabel!.snp.right).offset(6)
                make.centerY.equalToSuperview()
                make.width.equalTo(200)
                make.height.equalTo(26)
            })
        case .code:
            textField.placeholder = "请输入验证码"
            textField.snp.makeConstraints({ make in
                make.left.equalTo(textLabel!.snp.right).offset(6)
                make.centerY.equalToSuperview()
                make.width.equalTo(100)
                make.height.equalTo(26)
            })
        case .text:
            textLabel?.snp.makeConstraints({ make in
                make.left.equalTo(12)
                make.centerY.equalToSuperview()
                make.width.equalTo(65)
            })
            textField.snp.makeConstraints({ make in
                make.left.equalTo(textLabel!.snp.right).offset(6)
                make.right.equalTo(-12)
                make.centerY.equalToSuperview()
                make.height.equalTo(26)
            })
        }
    }
    
    var placeholder: String! {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.fontRegular(14)
        textField.textColor = UIColor(hexString: "#333333")
        return textField
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("获取验证码", for: .normal)
        button.setTitleColor(UIColor(hexString: "#FF54A8"), for: .normal)
        button.titleLabel?.font = .fontRegular(12)
        button.backgroundColor = UIColor(hexString: "#FFE6F2")
        button.setLayerCorner(radius: 13)
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
