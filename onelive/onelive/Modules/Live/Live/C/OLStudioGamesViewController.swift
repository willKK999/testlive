

import UIKit

class OLStudioGamesViewController: OLBaseViewController {

    var gameCodes: [OLLotteryGameCodeModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        self.showLoading()
        OLAPIManager.shared.getGameCodeList { [weak self]  result in
            guard let self = self else {return}
            self.hideLoading()
            if result.isSuccess {
                if let list = result.data {
                    self.gameCodes = list
                    self.setUI()
                }
            }
        }
    }
    
    func setUI() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(290.0 + oSafeAreaBottomHeight())
        }
        for i in 0..<gameCodes.count {
            let vc = OLStudioGamesSubViewController()
            vc.gameCode = gameCodes[i]
            self.addChild(vc)
            vc.view.frame = CGRect(x: oScreenWidth * CGFloat(i), y: 0, width: oScreenWidth, height: self.mainScrollView.height)
            self.mainScrollView.addSubview(vc.view)
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
        let view = UIView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 290.0 + oSafeAreaBottomHeight()))
        view.backgroundColor = UIColor(hexString: "#FFFFFF")
        view.roundCorners([.topLeft, .topRight], radius: 6)
        view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(oNavBarHeight)
        }
        
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(48 + oSafeAreaBottomHeight())
        }
        
        view.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        return view
    }()

    lazy var topView: OLStudioGamesTopView = {
        let view = OLStudioGamesTopView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: oNavBarHeight))
        view.gameCodes = gameCodes
        view.delegate = self
        return view
    }()
    
    lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 44, width: oScreenWidth, height: CGFloat(290.0 + oSafeAreaBottomHeight() - 48 - oNavBarHeight)))
        scrollView.bounces = false
        scrollView.delegate = topView
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: scrollView.width * CGFloat(gameCodes.count), height: 0)
        scrollView.contentOffset = CGPoint(x: oScreenWidth, y: 0)
        return scrollView
    }()
    
    lazy var bottomView: OLGamesBottomView = {
        let view = OLGamesBottomView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 48))
        return view
    }()
}

extension OLStudioGamesViewController: OLLiveCustomNavigationBarDelegate {
    func titlesView(didSelectedItemAt index: Int) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else{return}
            self.mainScrollView.contentOffset = CGPoint(x: Int(self.mainScrollView.width) * index, y: 0)
        }
    }
}


class OLStudioGamesSubViewController: OLBaseViewController {
    
    var gameCode: OLLotteryGameCodeModel!
    var gameList: [OLLotteryGameModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        OLAPIManager.shared.getLiveGameList(code: gameCode.code) { [weak self]  result in
            guard let self = self else {return}
            self.hideLoading()
            if result.isSuccess {
                if let list = result.data {
                    self.gameList = list
                    self.setupCollectionView()
                }
            }
        }
        
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    lazy var collectionView: UICollectionView = {
        // 设置 flowLayout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
        let itemWidth = (self.view.width - 10.0)/4.0
        flowLayout.itemSize = CGSize(width: itemWidth, height: 76)
        // 添加 collectionView，记得要设置 delegate 和 dataSource 的代理对象
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(OLStudioGamesCell.self, forCellWithReuseIdentifier: OLStudioGamesCell.description())
        return collectionView
    }()
}

extension OLStudioGamesSubViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        gameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OLStudioGamesCell.description(), for: indexPath) as! OLStudioGamesCell
        let model = gameList[indexPath.row]
        model.name = gameCode.name
        cell.model = model
        return cell
    }
}
