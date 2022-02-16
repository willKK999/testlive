

import UIKit


private let liveShowCellID = "LiveShowCellID"
private let recommendedHeaderID = "RecommendedHeaderID"
private let nowHeaderID = "NowHeaderID"

class OLLiveRecommendedViewController: UIViewController {

    var advList: [OLAdvModel] = Array()
    var recommendedList: [OLLiveItemModel] = Array()
    var hotList: [OLLiveItemModel] = Array()
    var bannerList: [OLAdvModel] = Array()
    var pageNum = 1
    var recommendedHeatList: [OLLiveItemModel] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        OLAPIManager.shared.getLiveAdvList { [weak self]  result in
            guard let self = self else {return}
            if result.isSuccess {
                if let list = result.data {
                    self.advList = list
                    self.collectionView.reloadData()
                }
            }
        }
        
        OLAPIManager.shared.getRecommend { [weak self]  result in
            guard let self = self else {return}
            if result.isSuccess {
                if let list = result.data?.list {
                    self.recommendedList = list
                    self.collectionView.reloadData()
                }
            }
        }
        
        OLAPIManager.shared.getRecommendByHeat(pageNum) { [weak self]  result in
            guard let self = self else {return}
            if result.isSuccess {
                if let list = result.data?.list {
                    self.recommendedHeatList = list
                    self.collectionView.reloadData()
                }
            }
        }
        
        OLAPIManager.shared.recommendNotice { [weak self] result in
            guard let self = self else {return}
            if result.isSuccess {
                if let notice = result.data {
                    
                }
            }
        }
        //公告
        let announcementView = OLLiveAnnouncementView()
        announcementView.show()
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
        collectionView.register(OLLiveRecommendedHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: recommendedHeaderID)
        collectionView.register(OLLiveNowHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: nowHeaderID)
        return collectionView
    }()

}
extension OLLiveRecommendedViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return recommendedList.count
        }
        return recommendedHeatList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: liveShowCellID, for: indexPath) as! OLLiveShowCell
        if indexPath.section == 0 {
            let model = recommendedList[indexPath.row]
            cell.model = model
        } else if indexPath.section == 1 {
            let model = recommendedHeatList[indexPath.row]
            cell.model = model
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return section == 0 ? CGSize(width: view.frame.size.width, height: 105.0) : CGSize(width: view.frame.size.width, height: 262.0)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if indexPath.section == 0 {
                let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: recommendedHeaderID, for: indexPath) as? OLLiveRecommendedHeaderView
                headView!.advList = advList
                return headView!
            }else {
                let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: nowHeaderID, for: indexPath) as? OLLiveNowHeaderView
                headView!.hotList = hotList
                headView!.bannerList = bannerList
                return headView!
            }
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if indexPath.section == 0 {
           let model  = recommendedList[indexPath.row]
            OLAPIManager.shared.checKicking(studioNum: model.studioNum!) { result in
                if result.isSuccess {
                    if let state = result.data,state == true {
                        OLNavigationManager.shared.pushToLiveDetailVC(model: model)
                    }
                }
            }
        }else {
            let model = recommendedHeatList[indexPath.row]
            OLAPIManager.shared.checKicking(studioNum: model.studioNum!) { result in
                if result.isSuccess {
                    if let state = result.data,state == true {
                        OLNavigationManager.shared.pushToLiveDetailVC(model: model)
                    }
                }
            }
        }
       
    }
}
