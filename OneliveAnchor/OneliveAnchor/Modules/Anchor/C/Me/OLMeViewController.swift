

import UIKit

class OLMeViewController: OLBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItems = rightButtonItems
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.top.equalTo(oSafeAreaTopHeight())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 导航栏透明
        (navigationController as! OLNavigationController).configClearNavBarAppearance()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 导航栏恢复
        (navigationController as! OLNavigationController).configNormalNavBarAppearance()
    }
    
    lazy var rightButtonItems: [UIBarButtonItem] = {
        let serviceButtonItem = UIBarButtonItem(customView: serviceButton)
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
        action: nil)
        spacer.width = 4
        return [spacer, serviceButtonItem]
    }()
    
    lazy var serviceButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        button.setImage(OLImage.icon_me_service, for: .normal)
        return button
    }()
    
    lazy var headerView: OLUserHeaderView = {
        let view = OLUserHeaderView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 100))
        view.backgroundColor = .clear
        return view
    }()
    
    private let titleArray = ["个人资料","开播历史","设置"]
    private let imageArray = [OLImage.anchor_info,OLImage.anchor_time,OLImage.anchor_setting]
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        tableView.separatorColor = OLColors.hex_EDEDED
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
        tableView.register(OLAnchorHomeCell.self, forCellReuseIdentifier: OLAnchorHomeCell.description())
        return tableView
    }()
    
}

extension OLMeViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titleArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        48
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OLAnchorHomeCell.description(), for: indexPath) as! OLAnchorHomeCell
        cell.imageView?.image = imageArray[indexPath.row]
        cell.textLabel?.text = titleArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
