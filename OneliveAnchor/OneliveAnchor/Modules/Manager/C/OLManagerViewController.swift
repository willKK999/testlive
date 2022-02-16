

import UIKit

class OLManagerViewController: OLBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftView)
        self.navigationItem.rightBarButtonItems = rightButtonItems
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    lazy var leftView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 146, height: 44))
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(11)
            make.centerY.equalToSuperview()
            make.height.equalTo(22)
        }
        return view
    }()
    
    lazy var titleLabel: UILabel =  {
        let label = UILabel()
        label.font = OLFont.PingFang_Medium16
        label.textColor = OLColors.hex_333333
        label.text = "Welcome muzhou"
        return label
    }()
    
    lazy var rightButtonItems: [UIBarButtonItem] = {
        let settingButtonItem = UIBarButtonItem(customView: settingButton)
        let gap = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
        action: nil)
        gap.width = 10
        let serviceButtonItem = UIBarButtonItem(customView: serviceButton)
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
        action: nil)
        spacer.width = 4
        return [spacer, serviceButtonItem, gap, settingButtonItem]
    }()
    
    lazy var settingButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        button.setImage(OLImage.icon_me_setting, for: UIControl.State.normal)
        return button
    }()
    
    lazy var serviceButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        button.setImage(OLImage.icon_me_service, for: .normal)
        return button
    }()

    lazy var headerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 287))
        view.backgroundColor = .clear
        view.addSubview(balanceView)
        balanceView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(192)
        }
        
        view.addSubview(menuView)
        menuView.snp.makeConstraints { make in
            make.top.equalTo(balanceView.snp.bottom)
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.height.equalTo(85)
        }
        
        return view
    }()
    
    lazy var balanceView: OLManagerHeaderView = {
        let view = OLManagerHeaderView()
        return view
    }()
    
    lazy var menuView: OLManagerMenuView = {
        let view = OLManagerMenuView()
        return view
    }()
    
    private let titleArray = ["主播管理","财务对账","转化提现","主播报表"]
    private let imageArray = [OLImage.icon_anchor_manager,OLImage.icon_financial,OLImage.icon_conversion_withdrawal,OLImage.icon_report]
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        tableView.separatorColor = OLColors.hex_EDEDED
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
        tableView.register(OLIncomeTypeCell.self, forCellReuseIdentifier: OLIncomeTypeCell.description())
        return tableView
    }()
    
}

extension OLManagerViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titleArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        48
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OLIncomeTypeCell.description(), for: indexPath) as! OLIncomeTypeCell
        cell.imageView?.image = imageArray[indexPath.row]
        cell.textLabel?.text = titleArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
