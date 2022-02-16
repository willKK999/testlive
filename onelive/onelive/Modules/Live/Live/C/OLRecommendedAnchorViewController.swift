

import UIKit

class OLRecommendedAnchorViewController: UIViewController {
    
    var live: OLLiveItemModel!
    var anchorList: [OLLiveItemModel] = []
    var hidden: Bool! {
        didSet {
            if hidden {
                UIView.animate(withDuration: 0.5, animations: { [self] in
                    var frame = contentView.frame
                    frame.origin.x += 124
                    contentView.frame = frame
                }) { [self] finished in
                    view.isHidden = hidden
                }
            }else {
                view.isHidden = hidden
                UIView.animate(withDuration: 0.5, animations: { [self] in
                    var frame = contentView.frame
                    frame.origin.x -= 124
                    contentView.frame = frame
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.isHidden = true
        view.backgroundColor = UIColor.clear
        view.addSubview(contentView)
        
        OLAPIManager.shared.getLiveRecommendList(studioNum: live.studioNum!) { [weak self]  result in
            guard let self = self else {return}
            if result.isSuccess {
                if let list = result.data?.list {
                    self.anchorList = list
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let view = touch?.view
        if view != contentView {
            hidden = true
        }
    }

    lazy var contentView: UIView = {
        let contentView = UIView(frame: CGRect(x: oScreenWidth, y: 0, width: 124, height: oScreenHeight))
        contentView.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.50)
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(oStatusBarHeight)
            make.left.equalToSuperview().offset(6)
            make.height.equalTo(20)
        }
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
        
        return contentView
    }()
    
    lazy var titleLabel: UILabel =  {
        titleLabel = UILabel()
        titleLabel.font = .fontRegular(14)
        titleLabel.textColor = UIColor.white
        titleLabel.text = "为你推荐"
        return titleLabel
    }()
    
    lazy var collectionView: UICollectionView = {
        // 设置 flowLayout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 6
        flowLayout.minimumLineSpacing = 6
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 12)
        flowLayout.itemSize = CGSize(width: 106, height: 106)
        // 添加 collectionView，记得要设置 delegate 和 dataSource 的代理对象
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(OLLiveShowCell.self, forCellWithReuseIdentifier: OLLiveShowCell.description())
        return collectionView
    }()
}

extension OLRecommendedAnchorViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.anchorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OLLiveShowCell.description(), for: indexPath) as! OLLiveShowCell
        let model = anchorList[indexPath.row]
        cell.model = model
        return cell
    }
}
