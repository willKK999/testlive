
import UIKit

class OLEditNicknameViewController: OLBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "编辑昵称"
        self.navigationItem.rightBarButtonItem = rightButtonItem
        setupUI()
    }
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("保存", for: .normal)
        button.setTitleColor(UIColor(hexString: "#FF54A8"), for: .normal)
        button.titleLabel?.font = UIFont.fontRegular(14)
        button.sizeToFit()
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -5)
        button.addTarget(self, action: #selector(saveButtonClick), for: .touchUpInside)
        return button
    }()
    
    lazy var rightButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(customView: saveButton)
        return button
    }()
    
    func setupUI() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#FFFFFF")
        view.addSubview(clearButton)
        clearButton.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.right.equalToSuperview().offset(-12)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        view.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(12)
            make.right.equalTo(clearButton.snp.left).offset(-10)
            make.height.equalTo(22)
        }
        view.addSubview(limitLabel)
        limitLabel.snp.makeConstraints { (make) in
            make.top.equalTo(textField.snp.bottom).offset(10)
            make.left.equalTo(10)
            make.height.equalTo(17)
        }
        view.addSubview(promptLabel)
        promptLabel.snp.makeConstraints { (make) in
            make.top.equalTo(textField.snp.bottom).offset(10)
            make.right.equalTo(-10)
            make.height.equalTo(17)
        }
        return view
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.text = "疯魔小太郎"
        textField.font = UIFont.fontMedium(16)
        textField.textColor = UIColor(hexString: "#333333")
        textField.placeholder = "请输入昵称"
        return textField
    }()
    
    lazy var clearButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "icon_edit_clear"), for: .normal)
        button.addTarget(self, action: #selector(clearButtonClick), for: .touchUpInside)
        return button
    }()
    
    lazy var limitLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.fontRegular(12)
        label.textColor = UIColor(hexString: "#666666")
        label.text = "(长度可以编辑8个中文)"
        return label
    }()
    
    lazy var promptLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.fontRegular(12)
        label.textColor = UIColor(hexString: "#666666")
        label.text = "可以免费改名一次"
        label.textAlignment = .right
        return label
    }()
}

extension OLEditNicknameViewController {
    
    @objc func saveButtonClick() {
        debugPrint("保存")
    }
    
    @objc func clearButtonClick() {
        textField.text = nil
    }
}
