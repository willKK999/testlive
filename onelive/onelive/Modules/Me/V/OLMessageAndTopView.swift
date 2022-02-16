

import UIKit

class OLMessageAndTopView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let itemWidth = (oScreenWidth - 34.0)/2
        addSubview(messageView)
        messageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(12)
            make.size.equalTo(CGSize(width: itemWidth, height: 76))
        }
        
        addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(messageView.snp.right).offset(10)
            make.size.equalTo(CGSize(width: itemWidth, height: 76))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var messageView: MeMessageView = {
        let view = MeMessageView()
        view.backgroundColor = .white
        view.setLayerCorner(radius: 7)
        
        return view
    }()
    
    lazy var topView: MeTopView = {
        let view = MeTopView()
        view.backgroundColor = .white
        view.setLayerCorner(radius: 7)
        return view
    }()
}

class MeMessageView: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.left.equalTo(10)
            make.height.equalTo(20)
        }
        
        addSubview(messageLabel)
        messageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(textLabel.snp.bottom)
            make.left.equalTo(10)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.textColor = UIColor(hexString: "#333333")
        textLabel.font = UIFont.fontRegular(14)
        textLabel.text = "消息"
        return textLabel
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#666666")
        label.font = UIFont.fontRegular(12)
        label.numberOfLines = 2
        label.text = "我们将为您打造一个舒服的娱乐空间 即日起使用…"
        return label
    }()
}

class MeTopView: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.left.equalTo(10)
            make.height.equalTo(20)
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(textLabel.snp.bottom)
            make.left.equalTo(25)
            make.right.equalToSuperview()
            make.height.equalTo(35)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.textColor = UIColor(hexString: "#333333")
        textLabel.font = UIFont.fontRegular(14)
        textLabel.text = "贡献榜"
        return textLabel
    }()
    
    lazy var collectionView: UICollectionView = {
        // 设置 flowLayout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 15
        flowLayout.minimumLineSpacing = 15
        flowLayout.sectionInset = UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: 30, height: 30)
        flowLayout.scrollDirection = .horizontal
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

extension MeTopView: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OLLiveShowCell.description(), for: indexPath) as! OLLiveShowCell
        return cell
    }
}
