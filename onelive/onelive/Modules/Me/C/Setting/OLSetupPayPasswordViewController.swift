

import UIKit

class OLSetupPayPasswordViewController: OLBaseViewController {

    private let titleArray = ["支付密码","确认密码","找回暗语"]
    private let placeholderArray = ["请输入支付密码(6位纯数字)","请输入支付密码","请输入找回暗语"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "支付密码设置"
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
        tableView.tableFooterView = footerView
        tableView.register(OLSettingCell.self, forCellReuseIdentifier: OLSettingCell.description())
        return tableView
    }()
    
    lazy var footerView: UIView = {
        let view = UIView(frame:CGRect(x: 0, y: 0, width: oScreenWidth, height: 275))
        let label = UILabel()
        label.text = "请谨慎找回暗语，密码丢失后，可通过手机+暗语找回"
        label.textColor = UIColor(hexString: "#666666")
        label.font = .fontRegular(12)
        view.addSubview(label)
        label.snp.makeConstraints({ make in
            make.top.equalTo(10)
            make.left.equalTo(12)
            make.height.equalTo(17)
        })
        let buttonView = OLMeFooterButtonView(frame: CGRect(x: 0, y: 215, width: oScreenWidth, height: 60))
        buttonView.footerButton.setTitle("确认", for: .normal)
        buttonView.footerButton.addTarget(self, action: #selector(confirmButtonClick), for: .touchUpInside)
        view.addSubview(buttonView)
        return view
    }()
}

extension OLSetupPayPasswordViewController {
    @objc func confirmButtonClick() {
        
    }
}

extension OLSetupPayPasswordViewController: UITableViewDelegate,UITableViewDataSource {
    
   
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
        let cell = OLTextFieldCell(style: .text)
        cell.textLabel?.text = titleArray[indexPath.row]
        cell.placeholder = placeholderArray[indexPath.row]
        return cell
    }
}

