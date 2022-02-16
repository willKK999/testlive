

import UIKit

class OLPayActivitiesViewController: UIViewController {

    var titles = ["游戏活动","直播活动"]
    var gameList: [OLActivitiesModel] = []
    var liveList: [OLActivitiesModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(430.0 + oSafeAreaBottomHeight())
        }
        
        OLAPIManager.shared.getRoomActList { [weak self]  result in
            guard let self = self else {return}
            if result.isSuccess {
                if let list = result.data?.gameList {
                    self.gameList = list
                }
                if let list = result.data?.liveList {
                    self.liveList = list
                }
                self.addChildVC()
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
    
    func addChildVC() {
        //游戏活动
        let gameActivitiesVC = OLActivitiesPageVC()
        gameActivitiesVC.list = gameList
        self.addChild(gameActivitiesVC)
        gameActivitiesVC.view.frame = mainScrollView.bounds
        mainScrollView.addSubview(gameActivitiesVC.view)
        //直播活动
        let liveActivitiesVC = OLActivitiesPageVC()
        liveActivitiesVC.list = liveList
        self.addChild(liveActivitiesVC)
        liveActivitiesVC.view.frame = CGRect(x: oScreenWidth, y: 0, width: oScreenWidth, height: mainScrollView.height)
        mainScrollView.addSubview(liveActivitiesVC.view)
    }
    
    lazy var contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 430.0 + oSafeAreaBottomHeight()))
        view.backgroundColor = UIColor(hexString: "#FFFFFF")
        view.roundCorners([.topLeft, .topRight], radius: 6)
        view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(oNavBarHeight)
        }
        view.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(oNavBarHeight)
            make.left.right.bottom.equalToSuperview()
        }
        return view
    }()
    
    lazy var topView: OLPayActivitiesTopView = {
        let view = OLPayActivitiesTopView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: oNavBarHeight))
        view.titles = titles
        view.delegate = self
        view.backButton.addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)
        return view
    }()
    
    lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 44, width: oScreenWidth, height: CGFloat(430.0 + oSafeAreaBottomHeight() - oNavBarHeight)))
        scrollView.bounces = false
        scrollView.delegate = topView
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: scrollView.width * CGFloat(titles.count), height: scrollView.height)
        return scrollView
    }()
    @objc func backButtonClick() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension OLPayActivitiesViewController: OLLiveCustomNavigationBarDelegate {
    func titlesView(didSelectedItemAt index: Int) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else{return}
            self.mainScrollView.contentOffset = CGPoint(x: Int(self.mainScrollView.width) * index, y: 0)
        }
    }
}





class OLActivitiesPageVC: UIViewController {
    
    var list: [OLActivitiesModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OLActivitiesPageCell.self, forCellReuseIdentifier: OLActivitiesPageCell.description())
        return tableView
    }()
}

extension OLActivitiesPageVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OLActivitiesPageCell.description(), for: indexPath) as! OLActivitiesPageCell
        cell.model = list[indexPath.section]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class OLActivitiesPageCell: UITableViewCell {
    
    var model: OLActivitiesModel? {
        didSet {
            if let url = URL(string: (model?.imgUrl)!) {
                backgroundImageView.kf.setImage(with: url)
            }
        }
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            var frame = newValue
            frame.origin.x = 12
            frame.size.width -= 24
            super.frame = frame
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 5
        
        self.contentView.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(hexString: "#F5F5F5")
        return imageView
    }()
    
}
