
import UIKit

private let liveShowCellID = "LiveShowCellID"

class OLLiveGameViewController: UIViewController {

    var pageNum = 1
    var popList: [OLLiveItemModel] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        
        OLAPIManager.shared.getLivePopList(pageNum) { [weak self]  result in
            guard let self = self else {return}
            if result.isSuccess {
                self.popList = (result.data?.list!)!
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
        return collectionView
    }()

}

extension OLLiveGameViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.popList.count == 0 ? 6 : self.popList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: liveShowCellID, for: indexPath) as! OLLiveShowCell
        if self.popList.count > 0 {
            let model = popList[indexPath.row]
            cell.model = model
        }
        return cell
    }
}
