

import UIKit

class OLEditSignatureViewController: OLBaseViewController {

    private let maxNumber = 32
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "修改个性签名"
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
//        button.customView?.frame = saveButton.frame
        return button
    }()
    
    func setupUI() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(160)
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
        view.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(18)
            make.left.equalTo(12)
            make.right.equalTo(clearButton.snp.left).offset(-10)
            make.bottom.equalTo(-50)
        }
        view.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.bottom.equalTo(-42)
            make.height.equalTo(1)
        }
        view.addSubview(numberLabel)
        numberLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.bottom.equalTo(-11)
            make.height.equalTo(20)
        }
        return view
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.font = UIFont.fontMedium(14)
        textView.textColor = UIColor(hexString: "#333333")
        textView.addSubview(placeholderLabel)
        textView.delegate = self
        placeholderLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(4.5)
            make.height.equalTo(20)
        }
        return textView
    }()
    
    lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.fontRegular(14)
        label.textColor = UIColor(hexString: "#C4C4C4")
        label.text = "请输入个性签名"
        label.textAlignment = .right
        return label
    }()
    
    lazy var clearButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "icon_edit_clear"), for: .normal)
        button.addTarget(self, action: #selector(clearButtonClick), for: .touchUpInside)
        return button
    }()
    
    lazy var lineView: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(hexString: "#F5F5F5")
        return line
    }()
    
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.fontRegular(14)
        label.textColor = UIColor(hexString: "#C4C4C4")
        label.text = "0/\(maxNumber)"
        label.textAlignment = .right
        return label
    }()
}

extension OLEditSignatureViewController {
    
    @objc func saveButtonClick() {
        debugPrint("保存")
    }
    
    @objc func clearButtonClick() {
        textView.text = nil
        numberLabel.text = "0/\(maxNumber)"
        placeholderLabel.isHidden = false
    }
}

extension OLEditSignatureViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let jointStr = (textView.text as NSString).replacingCharacters(in: range, with: text)
        placeholderLabel.isHidden = jointStr.count != 0
        let remainNumber = maxNumber - jointStr.count
        //当没有候选字符,且字数超过限制时，输入无效
        if remainNumber < 0 {
            return false
        }
        numberLabel.text = "\(jointStr.count)/\(maxNumber)"
        return true
    }
}
