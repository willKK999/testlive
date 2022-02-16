

import UIKit

class OLMineActivityViewController: UIViewController {
    
    var titles = ["游戏活动","直播活动"]
    var gameList: [OLActivitiesModel] = []
    var liveList: [OLActivitiesModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(oStatusAndNavBarHeight)
        }
        view.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(oStatusAndNavBarHeight)
            make.left.right.bottom.equalToSuperview()
        }
        view.bringSubviewToFront(topView)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override  func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(false, animated: false)
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
        liveActivitiesVC.view.frame = CGRect(x: oScreenWidth, y: 0, width: oScreenWidth, height: mainScrollView.bounds.height)
        mainScrollView.addSubview(liveActivitiesVC.view)
    }
    
    lazy var topView: OLMineActivityNavigationBar = {
        let view = OLMineActivityNavigationBar(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: oStatusAndNavBarHeight))
        view.titles = titles
        view.delegate = self
        view.backButton.addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)
        return view
    }()
    
    lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect.zero)
        scrollView.bounces = false
        scrollView.delegate = topView
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: oScreenWidth * CGFloat(titles.count), height: 0)
        return scrollView
    }()

    @objc func backButtonClick() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension OLMineActivityViewController: OLLiveCustomNavigationBarDelegate {
    func titlesView(didSelectedItemAt index: Int) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else{return}
            self.mainScrollView.contentOffset = CGPoint(x: Int(self.mainScrollView.width) * index, y: 0)
        }
    }
}
