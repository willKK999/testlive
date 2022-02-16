

import UIKit

class OLMeInformationViewController: OLBaseViewController {
    private let titleArray = ["个人信息","会员ID:752529947","家乡: 火星","职业: 全职主播","年龄: 保密","感情: 保密"]
    private let imageArray = [nil,"icon_user_id","icon_user_home","icon_user_occupation","icon_user_age","icon_user_marriage"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "风魔小太郎"
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    lazy var headerView: UIView = {
        let view = OLInformationHeaderView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 375))
       
        return view
    }()
    
    lazy var footerView: UIView = {
        let view = OLMeFooterButtonView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 75))
        view.footerButton.setTitle("编辑资料", for: .normal)
        view.footerButton.addTarget(self, action: #selector(editInfoButtonClick), for: .touchUpInside)
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        tableView.register(OLMeInformationCell.self, forCellReuseIdentifier: OLMeInformationCell.description())
        return tableView
    }()

}
//MARK: 事件
extension OLMeInformationViewController {
    @objc func editInfoButtonClick() {
        OLNavigationManager.shared.pushToEditInfoVC()
    }
}

extension OLMeInformationViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 40 : 32
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = OLMeInformationCell(style:.system)
        if indexPath.row == 0{
            cell = OLMeInformationCell(style:.title)
        }else  if indexPath.row == 1{
            cell = OLMeInformationCell(style:.copy)
        }
        cell.textLabel?.text = titleArray[indexPath.row]
        if let imageName = imageArray[indexPath.row] {
            cell.imageView?.image = UIImage(named: imageName)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
