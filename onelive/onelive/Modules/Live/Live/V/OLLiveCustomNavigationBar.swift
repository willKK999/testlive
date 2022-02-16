

import UIKit
import SnapKit

public protocol OLLiveCustomNavigationBarDelegate: AnyObject {
    func titlesView(didSelectedItemAt index:Int)
}

private let liveTitleCellIdentifier = "LiveTitleCellIdentifier"

class OLLiveCustomNavigationBar: UIView {
    weak open var delegate: OLLiveCustomNavigationBarDelegate?
    
    var selectedIndex = 0
    var columns: Array<OLColumnModel> = Array() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    var lineTransform: CGAffineTransform?
    var selectedCell: OLLiveTitleCell = OLLiveTitleCell()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(44.0)
        }
        
        self.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: lazy
    lazy var contentView: UIView = {
        let view = UIView()
        
        view.addSubview(leftView)
        leftView.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.width.equalTo(235.0)
            make.height.equalTo(44.0)
        }
        
        view.addSubview(rightView)
        rightView.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview()
            make.width.equalTo(60.0)
            make.height.equalTo(44.0)
        }
        return view
    }()
    
    lazy var leftView: UIView = {
        let view = UIView()
        view.addSubview(selectedBottomLine)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(5)
        }
        
        view.bringSubviewToFront(selectedBottomLine)
        lineTransform = selectedBottomLine.transform
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        // 设置 flowLayout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: 46, height: 44)
        // 添加 collectionView，记得要设置 delegate 和 dataSource 的代理对象
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(OLLiveTitleCell.self, forCellWithReuseIdentifier: liveTitleCellIdentifier)
        let indexPath = IndexPath(row: selectedIndex, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        return collectionView
    }()
    
    lazy var selectedBottomLine: UIView = {
        let view = UIView(frame: CGRect(x: 20, y: 36, width: 16, height: 2))
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 1
        view.addGradient([UIColor(hexString: "#FF68B2").cgColor,UIColor(hexString: "#FFB1B0").cgColor],startPoint:  CGPoint(x: 0.09, y: 0.13),endPoint: CGPoint(x: 0.94, y: 0.13))
        return view
    }()
   
    
    lazy var rightView: UIView = {
        let view = UIView()
        
        view.addSubview(nobleButton)
        nobleButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
        
        view.addSubview(searchButton)
        searchButton.snp.makeConstraints { (make) in
            make.right.equalTo(nobleButton.snp.left).offset(-12)
            make.centerY.equalToSuperview()
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
        return view
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "nav_search"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(searchButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    @objc func searchButtonClick() {
        OLNavigationManager.shared.currentPagePushToSearchVC()
    }
    
    lazy var nobleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "nav_noble"), for: UIControl.State.normal)
        return button
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
            frame.origin.x = CGFloat(20 + 46 * index)
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

extension OLLiveCustomNavigationBar: UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.columns.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: liveTitleCellIdentifier, for: indexPath) as? OLLiveTitleCell
        let model = columns[indexPath.row]
        cell?.titleLabel.text = model.columnName
        if selectedIndex == indexPath.row {
            cell?.setSelected(true)
            self.selectedCell = cell!
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
