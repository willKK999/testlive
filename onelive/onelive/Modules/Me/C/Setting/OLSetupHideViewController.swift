

import UIKit

class OLSetupHideViewController: OLBaseViewController {
    
    private let titleArray = ["入场隐身","榜单隐身"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置贵族隐身"
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
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorColor = UIColor(hexString: "#EEEEEE")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OLSettingCell.self, forCellReuseIdentifier: OLSettingCell.description())
        return tableView
    }()
}

extension OLSetupHideViewController: UITableViewDelegate,UITableViewDataSource {
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titleArray.count
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
        let cell = OLSettingCell(style: .rightSwitch)
        cell.textLabel?.text = titleArray[indexPath.row]
        return cell
    }
}
