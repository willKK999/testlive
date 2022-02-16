

import UIKit

class OLMeViewController: OLBaseViewController {

    private let titleArray = [["收支明细","游戏记录"],
                              ["手机认证","我的背包","等级","专属客服","设置"]]
    private let imageArray = [["icon_me_bill","icon_me_report"],
                              ["icon_me_phone","icon_me_backpack","icon_me_level","icon_me_service","icon_me_setting"]]
                                                        
    
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

    func setupUI() {
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(oStatusAndNavBarHeight)
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(navigationBar.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    lazy var navigationBar: OLCustomNavigationBar = {
        let navBar = OLCustomNavigationBar()
        navBar.settingButton.addTarget(self, action: #selector(settingButtonClick), for: .touchUpInside)
        return navBar
    }()
    
    lazy var headerView: OLMeHeaderView = {
        let view = OLMeHeaderView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 370))
        view.userInfoView.addTarget(self, action: #selector(userInfoButtonClick), for: .touchUpInside)
        view.userInfoView.editButton.addTarget(self, action: #selector(editInfoButtonClick), for: .touchUpInside)
        view.followView.addTarget(self, action: #selector(followButtonClick), for: .touchUpInside)
        view.fansView.addTarget(self, action: #selector(fansButtonClick), for: .touchUpInside)
        view.messageAndTopView.messageView.addTarget(self, action: #selector(messageButtonClick), for: .touchUpInside)
        view.messageAndTopView.topView.addTarget(self, action: #selector(topButtonClick), for: .touchUpInside)
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        tableView.separatorColor = UIColor(hexString: "#EDEDED")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
        tableView.register(OLMeCell.self, forCellReuseIdentifier: OLMeCell.description())
        return tableView
    }()
}

//MARK: action 事件
extension OLMeViewController {
    @objc func settingButtonClick() {
        OLNavigationManager.shared.pushToSettingVC()
    }
    
    @objc func userInfoButtonClick() {
        OLNavigationManager.shared.pushToInformationVC()
    }
    @objc func editInfoButtonClick() {
        OLNavigationManager.shared.pushToEditInfoVC()
    }
    @objc func followButtonClick() {
        OLNavigationManager.shared.pushToMineFollowVC()
    }
    @objc func fansButtonClick() {
        OLNavigationManager.shared.pushToMineFansVC()
    }
    @objc func messageButtonClick() {
        OLNavigationManager.shared.pushToMineMessageVC()
    }
    @objc func topButtonClick() {
        OLNavigationManager.shared.pushToMineMessageVC()
    }
}


extension OLMeViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 2 : 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        48
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
        UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OLMeCell.description(), for: indexPath) as! OLMeCell
        cell.imageView?.image = UIImage(named: imageArray[indexPath.section][indexPath.row])
        cell.textLabel?.text = titleArray[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section,indexPath.row) {
        case (0,0):
            break
        case (0,1):
            break
        case (1,0):
            OLNavigationManager.shared.pushToPhoneAuthenticationVC()
        case (1,1):
            break
        case (1,2):
            OLNavigationManager.shared.pushToMineLevelVC()
        case (1,3):
            break
        case (1,4):
            OLNavigationManager.shared.pushToSettingVC()
        default:break
        }
    }
}
