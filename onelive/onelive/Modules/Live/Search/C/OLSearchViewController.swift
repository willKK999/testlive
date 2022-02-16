

import UIKit

private let liveFollowHeaderView = "LiveFollowHeaderViewID"

class OLSearchViewController: UIViewController {

    var pageNum = 1
    var searchList: [OLLiveItemModel] = Array()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        self.view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override  func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setupUI() {
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(oStatusAndNavBarHeight)
        }
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    lazy var navigationBar: OLSearchCustomNavigationBar = {
        let navigationBar = OLSearchCustomNavigationBar()
        navigationBar.cancelButton.addTarget(self, action: #selector(cancelButtonClick), for: UIControl.Event.touchUpInside)
        navigationBar.searchTextField.delegate = self
        return navigationBar
    }()
    
    @objc func cancelButtonClick() {
        OLNavigationManager.shared.currentPagePopVC()
    }
    
    lazy var collectionView: UICollectionView = {
        // 设置 flowLayout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = 5
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        flowLayout.sectionHeadersPinToVisibleBounds = true
        let itemWidth = (self.view.width - 29.0)/2.0
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        // 添加 collectionView，记得要设置 delegate 和 dataSource 的代理对象
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(OLLiveShowCell.self, forCellWithReuseIdentifier: OLLiveShowCell.description())
        collectionView.register(OLLiveFollowHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: liveFollowHeaderView)
        return collectionView
    }()

}

extension OLSearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let searchText = textField.text {
            OLAPIManager.shared.getLiveSearchList(searchText:searchText, pageNum) { [weak self]  result in
                guard let self = self else {return}
                if result.isSuccess {
                    if let list = result.data?.list {
                        self.searchList = list
                        self.collectionView.reloadData()
                    }
                }
            }
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == " " {
            return false
        }
        return true
    }
}

extension OLSearchViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.searchList.count == 0 ? 4 : self.searchList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OLLiveShowCell.description(), for: indexPath) as! OLLiveShowCell
        if self.searchList.count != 0 {
            let model = searchList[indexPath.row]
            cell.model = model
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: oScreenWidth, height: 44.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: liveFollowHeaderView, for: indexPath) as! OLLiveFollowHeaderView
            headView.imageView.image = UIImage(named: "icon_recent")
            headView.titleLabel.text = "最近预览"
            headView.changeButton.isHidden = false
            return headView
        }
        return UICollectionReusableView()
    }
}
