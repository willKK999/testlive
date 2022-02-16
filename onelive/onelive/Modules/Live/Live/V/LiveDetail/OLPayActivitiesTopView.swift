

import UIKit

class OLPayActivitiesTopView: UIView {
    weak open var delegate: OLLiveCustomNavigationBarDelegate?
    var selectedIndex = 0
    var selectedCell: OLLiveTitleCell = OLLiveTitleCell()
    var lineTransform: CGAffineTransform?
    var titles = Array<String>() {
        didSet{
            self.collectionView.reloadData()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.left.equalTo(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 16, height: 17))
        }
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.equalTo(backButton.snp.right)
            make.right.equalToSuperview().offset(-28)
            make.top.bottom.equalToSuperview()
            
        }
        addSubview(bottomLine)
        bottomLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.right.bottom.equalToSuperview()
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "arrow_left_back"), for: UIControl.State.normal)
        return button
    }()
    
    let itemWidth = (oScreenWidth - 56)/2
    
    lazy var collectionView: UICollectionView = {
        // 设置 flowLayout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        flowLayout.itemSize = CGSize(width: itemWidth, height: 44)
        // 添加 collectionView，记得要设置 delegate 和 dataSource 的代理对象
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(OLLiveTitleCell.self, forCellWithReuseIdentifier:OLLiveTitleCell.description())
        let indexPath = IndexPath(row: selectedIndex, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        collectionView.addSubview(selectedBottomLine)
        lineTransform = selectedBottomLine.transform
        return collectionView
    }()
    
    let selectedX = (oScreenWidth - 56)/4 - 8
    lazy var selectedBottomLine: UIView = {
        let view = UIView(frame: CGRect(x:selectedX, y: 35, width: 16, height: 2))
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 1
        view.addGradient([UIColor(hexString: "#FF68B2").cgColor,UIColor(hexString: "#FFB1B0").cgColor],startPoint:  CGPoint(x: 0.09, y: 0.13),endPoint: CGPoint(x: 0.94, y: 0.13))
        return view
    }()
    
    lazy var bottomLine: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00).cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private func bottomLine(scrollToItemAt index:Int) {
        if selectedIndex == index {
            return
        }
        selectedIndex = index
        let transform = lineTransform
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else{return}
            var frame = self.selectedBottomLine.frame
            frame.origin.x = self.selectedX + self.itemWidth * CGFloat(index)
            self.selectedBottomLine.frame = frame
            self.selectedBottomLine.transform = transform!.scaledBy(x: 1.5, y: 1)
        } completion: {[weak self] finished in
            guard let self = self else{
                return
            }
            //动画结束后执行的操作
            self.selectedBottomLine.transform = transform!
        }
        
    }
    
    private func liveTitlesView(scrollDidSelectedItemAt index:Int) {
        let indexPath = IndexPath(row: index, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        if let cell = collectionView.cellForItem(at: indexPath) as? OLLiveTitleCell {
            selectedCell.setSelected(false)
            cell.setSelected(true)
            selectedCell = cell
            bottomLine(scrollToItemAt: index)
        }
    }
}

extension OLPayActivitiesTopView: UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        titles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OLLiveTitleCell.description(), for: indexPath) as? OLLiveTitleCell
        cell?.titleLabel.text = titles[indexPath.row]
        if selectedIndex == indexPath.row {
            cell?.setSelected(true)
            selectedCell = cell!
        }
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let cell = collectionView.cellForItem(at: indexPath) as? OLLiveTitleCell
        if selectedCell == cell {
            selectedCell.setSelected(true)
            return
        }
        if (delegate != nil) {
            delegate?.titlesView(didSelectedItemAt: indexPath.row)
        }
        selectedCell.setSelected(false)
        cell!.setSelected(true)
        selectedCell = cell!
        bottomLine(scrollToItemAt: indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / oScreenWidth)
        liveTitlesView(scrollDidSelectedItemAt: index)
    }
}

