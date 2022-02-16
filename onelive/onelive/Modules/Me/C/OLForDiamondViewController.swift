
import UIKit


private let forDiamondHeaderID = "ForDiamondHeaderID"

class OLForDiamondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "兑换钻石"
        self.navigationItem.rightBarButtonItem = rightButtonItem
        setupUI()
    }
    
    lazy var serviceButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "icon_me_service"), for: .normal)
        button.sizeToFit()
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -5)
        button.addTarget(self, action: #selector(serviceButtonClick), for: .touchUpInside)
        return button
    }()
    
    lazy var rightButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(customView: serviceButton)
        return button
    }()
    
    func setupUI() {
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
        let itemWidth = (self.view.width - 34.0)/3.0
        flowLayout.itemSize = CGSize(width: itemWidth, height: 75)
        // 添加 collectionView，记得要设置 delegate 和 dataSource 的代理对象
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(OLForDiamondCell.self, forCellWithReuseIdentifier: OLForDiamondCell.description())
        collectionView.register(OLForDiamondHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: forDiamondHeaderID)
        return collectionView
    }()
    
}

extension OLForDiamondViewController {
    
    @objc func serviceButtonClick() {
        
    }
}

extension OLForDiamondViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OLForDiamondCell.description(), for: indexPath) as! OLForDiamondCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
       CGSize(width: view.frame.size.width, height: 170.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if indexPath.section == 0 {
                let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: forDiamondHeaderID, for: indexPath) as? OLForDiamondHeaderView
                return headView!
            }
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

