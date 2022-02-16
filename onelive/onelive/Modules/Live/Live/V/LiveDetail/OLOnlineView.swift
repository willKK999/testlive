

import UIKit

class OLOnlineView: UIView {

    var onlineList: [OLOnlineModel]? = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(audienceButton)
        audienceButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 45, height: 18))
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.right.equalTo(audienceButton.snp.left).offset(-4)
            make.width.equalTo(36*4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView: UICollectionView = {
        // 设置 flowLayout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 6
        flowLayout.minimumLineSpacing = 6
        flowLayout.itemSize = CGSize(width: 30, height: 30)
        flowLayout.scrollDirection = .horizontal
        // 添加 collectionView，记得要设置 delegate 和 dataSource 的代理对象
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.contentMode = .right
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(OLOnlineAudienceAvatarCell.self, forCellWithReuseIdentifier: OLOnlineAudienceAvatarCell.description())
        return collectionView
    }()
    
    lazy var audienceButton: UIButton = {
        let button = OLReLayoutButton(style: .image_Text, space: 2)
        button.setImage(UIImage(named: "live_hot"), for: .normal)
        button.setTitle("99999", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.fontRegular(9)
        button.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.20)
        button.layer.cornerRadius = 9
        return button
    }()
}

extension OLOnlineView: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.onlineList!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OLOnlineAudienceAvatarCell.description(), for: indexPath) as! OLOnlineAudienceAvatarCell
        cell.model = self.onlineList![indexPath.row]
        return cell
    }
}



class OLOnlineAudienceAvatarCell: UICollectionViewCell {
    var model: OLOnlineModel! {
        didSet {
            if let url = URL(string: model.avatar ?? "") {
                backgroundImageView.kf.setImage(with: url, placeholder: UIImage(named: "user_avatar_icon"))
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 15
        self.layer.backgroundColor = UIColor.white.cgColor
        self.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "avatar"))
        return imageView
    }()
    
}
