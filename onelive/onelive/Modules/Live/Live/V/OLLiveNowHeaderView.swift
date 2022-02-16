

import UIKit
import SDCycleScrollView

class OLLiveNowHeaderView: UICollectionReusableView {

    var hotList: [OLLiveItemModel] = Array() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    var bannerList: [OLAdvModel] = Array() {
        didSet {
            var imageURLStrings: [String] = []
            for model in bannerList {
                imageURLStrings.append(model.advImg!)
            }
            if imageURLStrings.count > 0 {
                bannerView.imageURLStringsGroup = imageURLStrings
            } else {
                bannerView.localizationImageNamesGroup = ["banner0", "banner0", "banner0"]
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(12)
            make.height.equalTo(15)
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.height.equalTo(91)
        }
        
        addSubview(bannerView)
        bannerView.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.bottom.equalToSuperview()
            make.height.equalTo(120)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel =  {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.fontMedium(15)
        titleLabel.textColor = UIColor(red: 51 / 255.0, green: 51 / 255.0, blue: 51 / 255.0, alpha: 1.00)
        titleLabel.text = "正在热播"
        return titleLabel
    }()
    
    lazy var collectionView: UICollectionView = {
        // 设置 flowLayout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = 5
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        flowLayout.itemSize = CGSize(width: 108, height: 91)
        flowLayout.scrollDirection = .horizontal
        // 添加 collectionView，记得要设置 delegate 和 dataSource 的代理对象
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(OLLiveShowCell.self, forCellWithReuseIdentifier: OLLiveShowCell.description())
        return collectionView
    }()
    
    lazy var bannerView: SDCycleScrollView = {
        let cycleScrollView = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: oScreenWidth - 24, height: 120))
        cycleScrollView.backgroundColor = UIColor(red: 216 / 255.0, green: 216 / 255.0, blue: 216 / 255.0, alpha: 1.00)
        cycleScrollView.layer.cornerRadius = 5
        cycleScrollView.layer.masksToBounds = true
        return cycleScrollView
    }()
}

extension OLLiveNowHeaderView: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.hotList.count
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OLLiveShowCell.description(), for: indexPath) as! OLLiveShowCell
//        let model = hotList[indexPath.row]
//        cell.model = model
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        OLNavigationManager.shared.pushToLiveDetailVC(model: hotList[indexPath.row])
    }
}
