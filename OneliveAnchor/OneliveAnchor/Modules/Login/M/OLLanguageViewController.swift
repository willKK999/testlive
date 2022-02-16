

import UIKit

class OLLanguageViewController: OLBaseViewController {

    var list = ["繁体中文","English","Viet Nam","India"]
    var selectIndex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "多语言设置"
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.selectRow(at: IndexPath(row: selectIndex, section: 0), animated: false, scrollPosition: .none)
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorColor = OLColors.hex_EEEEEE
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OLLanguageCell.self, forCellReuseIdentifier: OLLanguageCell.description())
        return tableView
    }()
    

}


extension OLLanguageViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        48
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OLLanguageCell.description(), for: indexPath) as! OLLanguageCell
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectIndex = indexPath.row
    }
}
