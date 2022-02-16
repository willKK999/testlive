

import UIKit

class OLHomeViewController: OLBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.top.equalTo(oSafeAreaTopHeight())
        }
    }

    lazy var headerView: OLHomeHeaderView = {
        let view = OLHomeHeaderView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 200))
        view.backgroundColor = .clear
        return view
    }()
    
    private let titleArray = ["我的钱包","收入详情","推广","排行榜"]
    private let imageArray = [OLImage.anchor_wallet,OLImage.anchor_income ,OLImage.anchor_promote,OLImage.anchor_top]
    
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

extension OLHomeViewController: UITableViewDelegate,UITableViewDataSource {
    
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
