

import UIKit

class OLAccountsAndSecurityViewController: OLBaseViewController {

    private let titleArray = ["通过以下设置提高安全等级","绑定手机"]
    var detail = "去绑定手机"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "账号与安全"
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
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorColor = UIColor(hexString: "#EEEEEE")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        tableView.register(OLSettingCell.self, forCellReuseIdentifier: OLSettingCell.description())
        return tableView
    }()
    
    lazy var headerView: UIView = {
        let view = OLSecurityHeaderView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 188))
        return view
    }()
    
    lazy var footerView: UIView = {
        let view = OLSecurityFooterView(frame:CGRect(x: 0, y: 0, width: oScreenWidth, height: 150))
        return view
    }()

}
extension OLAccountsAndSecurityViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.row == 0 ? 40 : 48
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
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
        var cell = OLSettingCell(style:.title)
        if indexPath.row == 1 {
            cell = OLSettingCell(style: .rightTextArrow)
            cell.detailText = detail
        }
        cell.textLabel?.text = titleArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 1 {
            OLNavigationManager.shared.pushToPhoneAuthenticationVC()
        }
    }
}
