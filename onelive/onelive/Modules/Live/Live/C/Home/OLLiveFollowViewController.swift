

import UIKit


private let liveShowCellID = "LiveShowCellID"
private let liveFollowHeaderView = "LiveFollowHeaderViewID"

class OLLiveFollowViewController: UIViewController {

    let followHeaderDatas:[[String: Any]] =  [ ["icon": UIImage(named: "icon_collection")!,
                                              "title":"已关注主播"],
                                             ["icon": UIImage(named: "icon_recommended")!,
                                              "title":"已关注主播"]]
    var pageNum = 1
    var followList: [OLLiveItemModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        OLAPIManager.shared.visitorLogin { [weak self] (result) in
            guard let self = self else {return}
            if result.isSuccess {
                self.loadData()
            }
        }
        
    }
    
    func loadData() {
        OLAPIManager.shared.getLiveFocusList(pageNum) { [weak self]  result in
            guard let self = self else {return}
            if result.isSuccess {
                self.followList = (result.data?.list!)!
                self.collectionView.reloadData()
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
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = 5
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        flowLayout.sectionHeadersPinToVisibleBounds = true
//        flowLayout.headerReferenceSize = CGSize(width: view.frame.size.width, height: 44.0)
        let itemWidth = (self.view.width - 29.0)/2.0
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        // 添加 collectionView，记得要设置 delegate 和 dataSource 的代理对象
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(OLLiveShowCell.self, forCellWithReuseIdentifier: liveShowCellID)
        collectionView.register(OLLiveFollowHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: liveFollowHeaderView)
        return collectionView
    }()

}

extension OLLiveFollowViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        return self.followList.count == 0 ? 2 : self.followList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: liveShowCellID, for: indexPath) as! OLLiveShowCell
        if indexPath.section == 1 && self.followList.count != 0 {
            let model = followList[indexPath.row]
            cell.model = model
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: oScreenWidth, height: 44.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: liveFollowHeaderView, for: indexPath) as? OLLiveFollowHeaderView
            if indexPath.section == 0 {
                headView!.imageView.image = followHeaderDatas[indexPath.section]["icon"] as? UIImage
                headView!.titleLabel.text = followHeaderDatas[indexPath.section]["title"] as? String
                headView!.changeButton.isHidden = true
            }else {
                headView!.imageView.image = followHeaderDatas[indexPath.section]["icon"] as? UIImage
                headView!.titleLabel.text = followHeaderDatas[indexPath.section]["title"] as? String
                headView!.changeButton.isHidden = false
            }
            return headView!
        }
        return UICollectionReusableView()
    }
}
