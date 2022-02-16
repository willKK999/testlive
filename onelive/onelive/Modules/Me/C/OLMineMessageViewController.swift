

import UIKit

class OLMineMessageViewController: OLBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "消息"
        self.navigationItem.rightBarButtonItem = rightButtonItem
        setupUI()
    }
    
    lazy var readButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("一键已读", for: .normal)
        button.setTitleColor(UIColor(hexString: "#333333"), for: .normal)
        button.titleLabel?.font = UIFont.fontRegular(14)
        button.sizeToFit()
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -5)
        button.addTarget(self, action: #selector(readButtonClick), for: .touchUpInside)
        return button
    }()
    
    lazy var rightButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(customView: readButton)
        return button
    }()
    
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
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        tableView.separatorColor = UIColor(hexString: "#EDEDED")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = footerView
        tableView.register(OLMessageCell.self, forCellReuseIdentifier: OLMessageCell.description())
        return tableView
    }()
    lazy var footerView: UIView = {
        let view = UIView(frame:CGRect(x: 0, y: 0, width: oScreenWidth, height: 210))
        let buttonView = OLMeFooterButtonView(frame: CGRect(x: 0, y: 150, width: oScreenWidth, height: 60))
        buttonView.footerButton.setTitle("确认", for: .normal)
        buttonView.footerButton.addTarget(self, action: #selector(confirmButtonClick), for: .touchUpInside)
        view.addSubview(buttonView)
        return view
    }()
}

extension OLMineMessageViewController {
    @objc func readButtonClick() {
        
    }
    
    @objc func confirmButtonClick() {
        
    }
}

extension OLMineMessageViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        55
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
        var cell = OLMessageCell(style: .normal)
        cell.imageView?.image = UIImage(named: "icon_msg_bell")
        cell.textLabel?.text = "欧阳娜娜"
        cell.messageLabel.text = "她好像忘记签名了"
        if indexPath.row == 0 {
            cell = OLMessageCell(style: .system)
            cell.imageView?.image = UIImage(named: "icon_msg_email")
            cell.textLabel?.text = "系统消息"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            OLNavigationManager.shared.pushToSystemMessageVC()
        }
    }
}

