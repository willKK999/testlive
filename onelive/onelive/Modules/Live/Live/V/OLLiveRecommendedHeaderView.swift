

import UIKit

class OLLiveRecommendedHeaderView: UICollectionReusableView {

    var advList: [OLAdvModel] = Array() {
        didSet{
            collectionView.reloadData()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(73)
        }
        
        addSubview(noticeBGView)
        noticeBGView.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(32)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var noticeBGView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: oScreenWidth - 24, height: 32))
        view.backgroundColor = UIColor(hexString: "#F5F5F5")
        view.layer.cornerRadius = 16
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(11)
            make.centerY.equalToSuperview()
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(10)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(17)
        }
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        imageView.image = UIImage(named: "icon_notice")
        return imageView
    }()
    
    lazy var titleLabel: UILabel =  {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.fontRegular(12)
        titleLabel.textColor = UIColor(hexString: "#333333")
        titleLabel.text = "本平台将为你打造一个高端舒适的颜值社区"
        return titleLabel
    }()
    
    lazy var collectionView: UICollectionView = {
        // 设置 flowLayout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
        let itemWidth = (oScreenWidth - 64.0)/5.0
        flowLayout.itemSize = CGSize(width: itemWidth, height: 53)
        // 添加 collectionView，记得要设置 delegate 和 dataSource 的代理对象
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(OLRecommendedHeaderCell.self, forCellWithReuseIdentifier: OLRecommendedHeaderCell.description())
        return collectionView
    }()
    
}

extension OLLiveRecommendedHeaderView: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.advList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OLRecommendedHeaderCell.description(), for: indexPath) as! OLRecommendedHeaderCell
        let model = advList[indexPath.row]
        cell.model = model
        return cell
    }
}

