
import UIKit

class OLMeSettingViewController: OLBaseViewController {

    private let titleArray = [["账户安全中心","APP就用锁","语言"],
                              ["支付密码","贵族隐身","检查更新"]]
    var language = "简体中文"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    lazy var footerView: UIView = {
        let view = OLMeFooterButtonView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 120))
        view.footerButton.setTitle("切换账号", for: .normal)
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        tableView.separatorColor = UIColor(hexString: "#EEEEEE")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = footerView
        tableView.register(OLSettingCell.self, forCellReuseIdentifier: OLSettingCell.description())
        return tableView
    }()
}


extension OLMeSettingViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
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
        var cell = OLSettingCell(style:.arrow)
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                cell = OLSettingCell(style: .rightSwitch)
            }
            if indexPath.row == 2 {
                cell = OLSettingCell(style: .rightText)
                cell.detailText = language
            }
        }
        if indexPath.section == 1 && indexPath.row == 2 {
            cell = OLSettingCell(style: .update)
        }
        cell.textLabel?.text = titleArray[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section,indexPath.row) {
        case (0,0):
            OLNavigationManager.shared.pushToAccountsAndSecurityVC()
        case (0,1):
            break
        case (0,2):
            OLNavigationManager.shared.pushToSetupLanguageVC()
        case (1,0):
            OLNavigationManager.shared.pushToSetupPayPasswordVC()
        case (1,1):
            OLNavigationManager.shared.pushToSetupHideVC()
        case (1,2):
            break
        default:
            break
        }
    }
}
