

import UIKit

class OLContributionListViewController: UIViewController {

    var live: OLLiveItemModel!
    
    var contributeList: [OLLiveContributeModel] = []{
        didSet {
            let headerView = OLContributionListHeaderView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 260))
            headerView.contributeList = contributeList
            tableView.tableHeaderView = headerView
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(415.0 + oSafeAreaBottomHeight())
        }
        
        OLAPIManager.shared.getContributeList(studioNum: live.studioNum!) { [weak self]  result in
            guard let self = self else {return}
            if result.isSuccess {
                if let list = result.data {
                    self.contributeList = list
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let touch = touches.first else {
            return
        }
        let touchesPoint = touch.location(in: self.view)
        oPrint(touchesPoint)
        //判断是否点击到了不包含的view
        if !contentView.frame.contains(touchesPoint){
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    lazy var contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 415.0 + oSafeAreaBottomHeight()))
        view.backgroundColor = UIColor(hexString: "#FFFFFF")
        view.roundCorners([.topLeft, .topRight], radius: 6)
        view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(55)
        }
  
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        return view
    }()
    
    lazy var topView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 55))
        view.addSubview(titleTopLabel)
        titleTopLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }
        view.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.right.bottom.equalToSuperview()

        }
        return view
    }()
    
    lazy var titleTopLabel: UILabel = {
        let  label = UILabel()
        label.font = UIFont.fontRegular(16)
        label.textColor = UIColor.black
        label.text = "贡献榜"
        return label
    }()
    
    lazy var bottomLine: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(hexString: "F5F5F5").cgColor
        view.layer.borderWidth = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowColor = UIColor(hexString: "F5F5F5").cgColor
        return view
    }()
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        tableView.separatorColor = UIColor(hexString: "#979797",alpha: 0.3)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OLContributionListCell.self, forCellReuseIdentifier: OLContributionListCell.description())
        return tableView
    }()
}

extension OLContributionListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contributeList.count > 3 ? (contributeList.count - 3) : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        48
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OLContributionListCell.description(), for: indexPath) as! OLContributionListCell
        cell.NoLabel.text = String(indexPath.row + 4)
        cell.model = contributeList[indexPath.row + 3]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
