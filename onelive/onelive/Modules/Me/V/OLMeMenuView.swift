

import UIKit

class OLMeMenuView: UIView {

    private let titleArray = ["钱包","提现","贵族","活动中心","推广赚钱"]
    private let imageArray = ["icon_me_wallet","icon_me_withdrawal","icon_me_noble","icon_me_activity","icon_me_promote"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-10)
        }
        collectionView.setLayerCorner(radius: 6)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView: UICollectionView = {
        // 设置 flowLayout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        let itemWidth = (oScreenWidth - 24.0)/CGFloat(titleArray.count)
        flowLayout.itemSize = CGSize(width: itemWidth, height: 85)
        flowLayout.scrollDirection = .horizontal
        // 添加 collectionView，记得要设置 delegate 和 dataSource 的代理对象
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.contentMode = .right
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(OLMeMenuCell.self, forCellWithReuseIdentifier: OLMeMenuCell.description())
        return collectionView
    }()

}

extension OLMeMenuView: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OLMeMenuCell.description(), for: indexPath) as! OLMeMenuCell
        cell.iconImageView.image = UIImage(named: imageArray[indexPath.row])
        cell.titleLabel.text = titleArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            OLNavigationManager.shared.pushToMineWalletVC()
        case 1:
            break
        case 2:
            OLNavigationManager.shared.pushToMineNobleVC()
        case 3:
            OLNavigationManager.shared.pushToMineActivityVC()
        default:break
        }
    }
}

class OLMeMenuCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
            make.height.equalTo(17)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor(hexString: "#333333")
        titleLabel.font = UIFont.fontRegular(12)
        return titleLabel
    }()
}
