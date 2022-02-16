

import UIKit

class OLWatchListViewController: UIViewController {
    
    var live: OLLiveItemModel!
    
    var guardList: [OLLiveGuardModel] = [] {
        didSet {
            let headerView = OLWatchListHeaderView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 135))
            headerView.model = guardList.first
            tableView.tableHeaderView = headerView
            self.tableView.reloadData()
            titleTopLabel.text = "守护榜(\(String(guardList.count)))" 
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(400.0 + oSafeAreaBottomHeight())
        }
        
        
        OLAPIManager.shared.getLiveGuardList(studioNum: live.studioNum!) { [weak self]  result in
            guard let self = self else {return}
            if result.isSuccess {
                if let list = result.data {
                    self.guardList = list
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
        let view = UIView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 400.0 + oSafeAreaBottomHeight()))
        view.backgroundColor = UIColor(hexString: "#FFFFFF")
        view.roundCorners([.topLeft, .topRight], radius: 20)
        view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(50)
        }
        
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.height.equalTo(55)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-oSafeAreaBottomHeight())
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
        return view
    }()
    
    lazy var topView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 55))
        view.addSubview(titleTopLabel)
        titleTopLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16)
        }
        view.addSubview(instructionsButton)
        instructionsButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(19)
            make.size.equalTo(CGSize(width: 16, height: 16))
        }
        return view
    }()
    
    lazy var titleTopLabel: UILabel = {
        let  label = UILabel()
        label.font = UIFont.fontRegular(16)
        label.textColor = UIColor.black
        label.text = "守护榜"
        return label
    }()
    
    lazy var instructionsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "icon_instructions"), for: .normal)
        button.addTarget(self, action: #selector(instructionsButtonClick), for: .touchUpInside)
        return button
    }()
    
    lazy var typeView: OLListTypeView = {
        let view = OLListTypeView(style: .watch)
        return view
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 55))
        view.addSubview(topLine)
        topLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.right.top.equalToSuperview()

        }
        
        view.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        view.addSubview(titleBottomLabel)
        titleBottomLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarImageView.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
        
        view.addSubview(openButton)
        openButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 76, height: 24))
        }
        return view
    }()
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "avatar"))
        return imageView
    }()
    
    lazy var titleBottomLabel: UILabel = {
        let  label = UILabel()
        label.font = UIFont.fontRegular(16)
        label.textColor = UIColor.black
        label.text = "开通TA，成为我的人"
        return label
    }()
    
    lazy var openButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0,width: 76, height: 24)
        button.setTitle("开通守护", for: .normal)
        button.setTitleColor(UIColor(hexString: "#FFFFFF"), for: .normal)
        button.titleLabel?.font = UIFont.fontMedium(14)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12
        button.addGradient([UIColor(hexString: "#FFB1E5").cgColor,UIColor(hexString: "#FF73C4").cgColor], startPoint: CGPoint(x: 0.84, y: 0.00),endPoint: CGPoint(x: 0.84, y: 0.86))
        return button
    }()
    
    lazy var topLine: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(hexString: "F5F5F5").cgColor
        view.layer.borderWidth = 1
        view.layer.shadowOffset = CGSize(width: 0, height: -1)
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
        tableView.register(OLWatchListCell.self, forCellReuseIdentifier: OLWatchListCell.description())
        return tableView
    }()
}
//MARK: 事件
extension OLWatchListViewController {
    @objc func instructionsButtonClick() {
        self.dismiss(animated: true, completion: nil)
        OLNavigationManager.shared.mainPagePushToGuardianInstructionsVC()
    }
}

extension OLWatchListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.guardList.count > 0 ? (self.guardList.count - 1) : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        48
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OLWatchListCell.description(), for: indexPath) as! OLWatchListCell
        cell.model = guardList[indexPath.row + 1]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


