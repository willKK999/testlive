

import UIKit

class OLEditInfoViewController: OLBaseViewController {
    
    private let titleArray = [["头像","昵称","账号","性别","签名"],
                              ["生日","感情","国家","职业"]]
    private var details = [[nil,"风魔小太郎","423462757","男","TA好像忘记签名了"],
                           ["2021-09-22","恋爱","火星","歌手"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "个人资料"
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
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        tableView.separatorColor = UIColor(hexString: "#EEEEEE")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OLSettingCell.self, forCellReuseIdentifier: OLSettingCell.description())
        return tableView
    }()
    
}

extension OLEditInfoViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 5 : 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return  68
        }
        return 48
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
        var cell = OLSettingCell(style:.rightTextArrow)
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell = OLSettingCell(style: .rightImage)
            }
            if indexPath.row == 2 {
                cell = OLSettingCell(style: .rightText)
            }
        }
        cell.textLabel?.text = titleArray[indexPath.section][indexPath.row]
        if let text = details[indexPath.section][indexPath.row] {
            cell.detailText = text
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section,indexPath.row) {
        case (0,0):
            let selectImageView = OLSelectImageView()
            selectImageView.show()
        case (0,1):
            OLNavigationManager.shared.pushToEditNicknameVC()
        case (0,2):
            break
        case (0,3):
            let selectGenderView = OLPickerView(style: .gender) { [weak self] answer in
                guard let self = self else {return}
                self.reloadTableView(indexPath: indexPath, answer: answer)
            }
            selectGenderView.show()
        case (0,4):
            OLNavigationManager.shared.pushToEditSignatureVC()
        case (1,0):
            let selectDateView = OLPickerView(style: .date) { [weak self] answer in
                guard let self = self else {return}
                self.reloadTableView(indexPath: indexPath, answer: answer)
            }
            selectDateView.show()
        case (1,1):
            let selectMarriageView = OLPickerView(style: .marriage) { [weak self] answer in
                guard let self = self else {return}
                self.reloadTableView(indexPath: indexPath, answer: answer)
            }
            selectMarriageView.show()
        case (1,2):
            let selectAddressView = OLPickerView(style: .address) { [weak self] answer in
                guard let self = self else {return}
                self.reloadTableView(indexPath: indexPath, answer: answer)
            }
            selectAddressView.show()
        case (1,3):
            let selectJobView = OLPickerView(style: .job) { [weak self] answer in
                guard let self = self else {return}
                self.reloadTableView(indexPath: indexPath, answer: answer)
            }
            selectJobView.show()
        default:
            break
        }
    }
    
    func reloadTableView(indexPath: IndexPath,answer: String) {
        self.details[indexPath.section][indexPath.row] = answer
        self.tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
}
