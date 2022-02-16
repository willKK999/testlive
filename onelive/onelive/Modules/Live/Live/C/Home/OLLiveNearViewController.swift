

import UIKit

private let liveShowCellID = "LiveShowCellID"

class OLLiveNearViewController: UIViewController {

    var pageNum = 1
    var nearbyList: [OLLiveItemModel] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        OLAPIManager.shared.getLiveNearbyList(pageNum) { [weak self]  result in
            guard let self = self else {return}
            if result.isSuccess {
                self.nearbyList = (result.data?.list!)!
                self.collectionView.reloadData()
            }
        }
    }
    
    func setupUI() {
        view.addSubview(screeningView)
        screeningView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(38)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(screeningView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    lazy var screeningView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 38))
        
        view.addSubview(locationButton)
        locationButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(12)
            make.size.equalTo(CGSize(width: 64, height: 28))
        }
        
        view.addSubview(limitButton)
        limitButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(locationButton.snp.right).offset(10)
            make.size.equalTo(CGSize(width: 64, height: 28))
        }
        return view
    }()
    
    lazy var locationButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 58, height: 20)
        button.setTitle("海外", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .fontRegular(12)
        button.backgroundColor = UIColor(red: 255 / 255.0, green: 84 / 255.0, blue: 168 / 255.0, alpha: 1.00)
        button.layer.cornerRadius = 12
        return button
    }()
    
    lazy var limitButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 58, height: 20)
        button.setTitle("不限", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .fontRegular(12)
        button.backgroundColor = UIColor(red: 255 / 255.0, green: 84 / 255.0, blue: 168 / 255.0, alpha: 1.00)
        button.layer.cornerRadius = 12
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        // 设置 flowLayout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = 5
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
        let itemWidth = (self.view.width - 29.0)/2.0
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        // 添加 collectionView，记得要设置 delegate 和 dataSource 的代理对象
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(OLLiveShowCell.self, forCellWithReuseIdentifier: liveShowCellID)
        return collectionView
    }()

}

extension OLLiveNearViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.nearbyList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: liveShowCellID, for: indexPath) as! OLLiveShowCell
        let model = nearbyList[indexPath.row]
        cell.model = model
        return cell
    }
}
