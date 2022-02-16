

import UIKit

class OLSetupLanguageViewController: OLBaseViewController {

    private let titleArray = ["跟随系统","简体中文","繁体中文"]
    
    var selectedIndex = 1
    var selectedCell: OLSettingCell = OLSettingCell(style: .imageAccessory)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "多语言设置"
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


extension OLSetupLanguageViewController: UITableViewDelegate,UITableViewDataSource {
    
   
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
        let cell = OLSettingCell(style: .imageAccessory)
        cell.textLabel?.text = titleArray[indexPath.row]
        if selectedIndex == indexPath.row {
            cell.setSelected(true)
            self.selectedCell = cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! OLSettingCell
        if selectedCell == cell {
            selectedCell.setSelected(true)
            return
        }
        selectedCell.setSelected(false)
        cell.setSelected(true)
        selectedIndex = indexPath.row
        selectedCell = cell
    }
}
