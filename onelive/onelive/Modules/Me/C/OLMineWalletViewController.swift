

import UIKit

class OLMineWalletViewController: OLBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的资产"
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
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OLMineWalletCell.self, forCellReuseIdentifier: OLMineWalletCell.description())
        return tableView
    }()
    

}

extension OLMineWalletViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
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
        var cell: OLMineWalletCell!
        switch indexPath.section {
        case 0:
            cell = OLMineWalletCell(style: .balance)
            cell.titleLabel.text = "余额"
            cell.recordButton.addTarget(self, action: #selector(recordButtonClick), for: .touchUpInside)
        case 1:
            cell = OLMineWalletCell(style: .diamond)
            cell.titleLabel.text = "我的钻石"
            cell.recordButton.addTarget(self, action: #selector(recordButtonClick), for: .touchUpInside)
            cell.exchangeButton.addTarget(self, action: #selector(exchangeButtonClick), for: .touchUpInside)
        default:
            cell = OLMineWalletCell(style: .other)
            cell.exchangeButton.addTarget(self, action: #selector(exchangeButtonClick), for: .touchUpInside)
        }
        cell.textLabel?.text = "2412.42"
        return cell
    }
}


extension OLMineWalletViewController {
    @objc func recordButtonClick() {
        OLNavigationManager.shared.pushToMinePWRecordVC()
    }
    @objc func exchangeButtonClick() {
        OLNavigationManager.shared.pushToForDiamondVC()
    }
}
