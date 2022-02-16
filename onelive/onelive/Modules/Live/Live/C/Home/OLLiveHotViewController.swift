

import UIKit

private let liveShowCellID = "LiveShowCellID"
private let bannerHeaderID = "BannerHeaderID"

class OLLiveHotViewController: UIViewController {

    var pageNum = 1
    var hotList: [OLLiveItemModel] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        
        OLAPIManager.shared.getLiveHotList(pageNum) { [weak self]  result in
            guard let self = self else {return}
            if result.isSuccess {
                self.hotList = (result.data?.list!)!
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
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
        let itemWidth = (self.view.width - 29.0)/2.0
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        // 添加 collectionView，记得要设置 delegate 和 dataSource 的代理对象
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(OLLiveShowCell.self, forCellWithReuseIdentifier: liveShowCellID)
        collectionView.register(OLLiveBannerView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: bannerHeaderID)
        return collectionView
    }()

}

extension OLLiveHotViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.hotList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: liveShowCellID, for: indexPath) as! OLLiveShowCell
        let model = hotList[indexPath.row]
        cell.model = model
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: oScreenWidth, height: 100.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: bannerHeaderID, for: indexPath) as? OLLiveBannerView
            return headView!
        }
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        OLNavigationManager.shared.pushToLiveDetailVC(model: hotList[indexPath.row])
    }
}
