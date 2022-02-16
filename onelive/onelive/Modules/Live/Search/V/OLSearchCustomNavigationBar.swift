

import UIKit

class OLSearchCustomNavigationBar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(44.0)
        }
        
        self.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 20))
        }
        
        view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.right.equalTo(cancelButton.snp.left).offset(-10)
            make.centerY.equalToSuperview()
            make.height.equalTo(32)
        }
        return view
    }()
    
    lazy var searchTextField: OLSearchTextField = {
        let searchTextField = OLSearchTextField(frame: CGRect(x: 0, y: 0, width: oScreenWidth - 75, height: 32))
        searchTextField.backgroundColor = UIColor(red: 245 / 255.0, green: 245 / 255.0, blue: 245 / 255.0, alpha: 1.00)
        searchTextField.layer.cornerRadius = 20
        searchTextField.attributedPlaceholder = NSMutableAttributedString(
            string: "请输入会员ID或昵称",
            attributes: [
                NSAttributedString.Key.font: UIFont.fontRegular(13),
                NSAttributedString.Key.foregroundColor: UIColor(red: 153 / 255.0, green: 153 / 255.0, blue: 153 / 255.0, alpha: 1.00)
            ])
        searchTextField.font = UIFont.fontRegular(13)
        //left
        let leftView = UIImageView(image: UIImage(named: "icon_text_search"))
        leftView.frame = CGRect(x: 14, y: 7, width: 18, height: 18)
        searchTextField.leftView = leftView
        searchTextField.leftViewMode = .always
        //right
        let rightView = UIImageView(frame: CGRect(x: 0, y: 7, width: 18, height: 18))
        rightView.image = UIImage(named: "icon_text_cancel")
        searchTextField.rightView = rightView
        searchTextField.rightViewMode = .always
        
        searchTextField.returnKeyType = .search
        searchTextField.enablesReturnKeyAutomatically = true
        return searchTextField
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("取消", for: .normal)
        button.setTitleColor(UIColor(red: 255 / 255.0, green: 84 / 255.0, blue: 168 / 255.0, alpha: 1.00), for: .normal)
        button.titleLabel?.font = .fontMedium(14)
        return button
    }()
    
    lazy var bottomLine: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00).cgColor
        view.layer.borderWidth = 1
        return view
    }()
}
