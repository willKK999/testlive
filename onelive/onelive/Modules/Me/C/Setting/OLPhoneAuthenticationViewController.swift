

import UIKit

class OLPhoneAuthenticationViewController: UIViewController {

    private let titleArray = ["国家和地区","+86","验证码"]
    var detail = "中国"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "手机认证"
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        tableView.separatorColor = UIColor(hexString: "#EEEEEE")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = footerView
        tableView.register(OLSettingCell.self, forCellReuseIdentifier: OLSettingCell.description())
        tableView.register(OLTextFieldCell.self, forCellReuseIdentifier: OLTextFieldCell.description())
        return tableView
    }()
    
    lazy var footerView: UIView = {
        let view = UIView(frame:CGRect(x: 0, y: 0, width: oScreenWidth, height: 150))
        let buttonView = OLMeFooterButtonView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 90))
        buttonView.footerButton.setTitle("验证", for: .normal)
        buttonView.footerButton.addTarget(self, action: #selector(validationButtonClick), for: .touchUpInside)
        view.addSubview(buttonView)
        let certificationView  = OLSafetyCertificationView(frame:CGRect(x: 0, y: 90, width: oScreenWidth, height: 150))
        view.addSubview(certificationView)
        return view
    }()

}

extension OLPhoneAuthenticationViewController {
    @objc func validationButtonClick() {
        
    }
}

extension OLPhoneAuthenticationViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        48
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = OLSettingCell(style:.rightTextArrow)
            cell.detailText = detail
            cell.textLabel?.text = titleArray[indexPath.row]
            return cell
        }
        var cell = OLTextFieldCell(style: .phone)
        if indexPath.row == 1 {
            
        }else if indexPath.row == 2 {
            cell = OLTextFieldCell(style: .code)
        }
        cell.textLabel?.text = titleArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
