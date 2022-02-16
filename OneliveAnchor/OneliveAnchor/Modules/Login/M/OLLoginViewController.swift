

import UIKit

public let RoleNotification = Notification.Name("UserRole")

class OLLoginViewController: OLBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override  func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    lazy var languageButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("语言", for: UIControl.State.normal)
        button.setTitleColor(OLColors.hex_333333, for: UIControl.State.normal)
        button.titleLabel?.font = OLFont.PingFang_Medium18
        button.addTarget(self, action: #selector(languageButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var welcomeLabel: UILabel =  {
        let label = UILabel()
        label.font = OLFont.PingFang_Medium16
        label.textColor = OLColors.hex_333333
        label.text = "Welcome"
        return label
    }()
    
    lazy var beginLabel: UILabel =  {
        let label = UILabel()
        label.font = OLFont.PingFang_Medium16
        label.textColor = OLColors.hex_333333
        label.text = "开始直播生活"
        return label
    }()

    lazy var IDTextField: UITextField = {
        let textField = OLLoginTextField()
        textField.placeholder = "平台ID"
        return textField
    }()
    
    lazy var accountTextField: UITextField = {
        let textField = OLLoginTextField()
        textField.placeholder = "账号"
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = OLPasswordTextField()
        textField.placeholder = "密码"
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(OLImage.icon_login_normal, for: .normal)
        button.setImage(OLImage.icon_login_disabled, for: .disabled)
        button.titleLabel?.font = OLFont.PingFang_Medium18
        button.addTarget(self, action: #selector(loginButtonClick), for: UIControl.Event.touchUpInside)
//        button.isEnabled = false
        return button
    }()
    
    func setupUI() {
        view.addSubview(languageButton)
        languageButton.snp.makeConstraints { make in
            make.top.equalTo(oSafeAreaTopHeight() + 5)
            make.right.equalTo(-38)
        }
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(languageButton.snp.bottom)
            make.left.equalTo(38)
        }
        view.addSubview(beginLabel)
        beginLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(5)
            make.left.equalTo(38)
        }
        view.addSubview(IDTextField)
        IDTextField.snp.makeConstraints { make in
            make.top.equalTo(beginLabel.snp.bottom).offset(20)
            make.left.equalTo(38)
            make.right.equalTo(-38)
            make.height.equalTo(40)
        }
        view.addSubview(accountTextField)
        accountTextField.snp.makeConstraints { make in
            make.top.equalTo(IDTextField.snp.bottom).offset(15)
            make.left.equalTo(38)
            make.right.equalTo(-38)
            make.height.equalTo(40)
        }
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(accountTextField.snp.bottom).offset(15)
            make.left.equalTo(38)
            make.right.equalTo(-38)
            make.height.equalTo(40)
        }
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(175)
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.height.equalTo(48)
        }
    }
}

extension OLLoginViewController {
    @objc func languageButtonClick() {
        OLNavigationManager.shared.currentPagePushToLanguageVC()
    }
    @objc func loginButtonClick() {
        let  alertController =  UIAlertController(title: "Welcome" ,
                                                   message: "开始直播生活" , preferredStyle: .alert)
        let  anchorAction =  UIAlertAction(title: "主播" , style: .default, handler:  {
            action  in
            NotificationCenter.default.post(name: RoleNotification, object: nil, userInfo: ["role":"anchor"])
        })
        let  managerAction =  UIAlertAction(title:  "家族长" , style: . default , handler: {
            action  in
            NotificationCenter.default.post(name: RoleNotification, object: nil, userInfo: ["role":"manager"])
        })
        alertController.addAction(anchorAction)
        alertController.addAction(managerAction)
        self.navigationController?.present(alertController, animated:  true , completion:  nil )
    }
}
