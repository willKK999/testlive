

import UIKit

enum ListTypeStyles: Int {
    case contribution
    case watch
}

class OLListTypeView: UIView {
    
    weak open var delegate: OLLiveCustomNavigationBarDelegate?
    var titles = ["日榜","周榜","月榜","总榜"]
    var selectedIndex = 0
    var selectedCell: OLWatchListTypeCell = OLWatchListTypeCell()
    var lineTransform: CGAffineTransform?
    var style: ListTypeStyles!
    
    init(style:ListTypeStyles) {
        super.init(frame: .zero)
        self.style = style
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(240)
        }
        
        addSubview(topListButton)
        topListButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(42)
        }
    }
    
    lazy var collectionView: UICollectionView = {
        // 设置 flowLayout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = 5
        flowLayout.sectionInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        flowLayout.itemSize = CGSize(width: 55, height: 22)
        // 添加 collectionView，记得要设置 delegate 和 dataSource 的代理对象
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(OLWatchListTypeCell.self, forCellWithReuseIdentifier: OLWatchListTypeCell.description())
        let indexPath = IndexPath(row: selectedIndex, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        return collectionView
    }()
    
    lazy var topListButton: UIButton = {
        let button = UIButton(type: .custom)
//        button.setImage(UIImage(named: "icon_top_list"), for: .normal)
        button.setTitle("排行榜", for: .normal)
        button.titleLabel?.font = UIFont.fontMedium(14)
        switch style {
        case .contribution:
            button.setTitleColor(UIColor(hexString: "#FFFFFF"), for: .normal)
        case .watch:
            button.setTitleColor(UIColor(hexString: "#333333"), for: .normal)
        case .none:
            break
        }
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OLListTypeView: UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        titles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OLWatchListTypeCell.description(), for: indexPath) as! OLWatchListTypeCell
        cell.style = style
        cell.titleLabel.text = titles[indexPath.row]
        if selectedIndex == indexPath.row{
            cell.setSelected(true)
            selectedCell = cell
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let cell = collectionView.cellForItem(at: indexPath) as? OLWatchListTypeCell
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
    }
}

class OLWatchListTypeCell: UICollectionViewCell {

    var style: ListTypeStyles! {
        didSet {
            switch style {
            case .contribution:
                titleLabel.textColor = UIColor(hexString: "#615EF3")
                titleLabel.backgroundColor = UIColor(hexString: "#E4E3FF")
            case .watch:
                titleLabel.textColor = UIColor(hexString: "#333333")
                titleLabel.layer.backgroundColor = UIColor(hexString: "#E5E5E5").cgColor
            case .none:
                break
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel =  {
        let titleLabel = UILabel(frame:CGRect(x: 0, y: 0, width: 56, height: 22))
        titleLabel.textAlignment = .center
        titleLabel.font = .fontRegular(14)
        titleLabel.text = "日榜"
        titleLabel.layer.masksToBounds = true
        titleLabel.layer.cornerRadius = 11
        return titleLabel
    }()

    func setSelected(_ selected: Bool) {
        if selected {
            titleLabel.font = .fontMedium(14)
            titleLabel.textColor = UIColor(hexString: "#615EF7")
            titleLabel.backgroundColor = UIColor(hexString: "#FFFFFF")
        } else {
            titleLabel.font = .fontRegular(14)
            switch style {
            case .contribution:
                titleLabel.textColor = UIColor(hexString: "#615EF3")
                titleLabel.backgroundColor = UIColor(hexString: "#E4E3FF")
            case .watch:
                titleLabel.textColor = UIColor(hexString: "#333333")
                titleLabel.addGradient([UIColor(hexString: "#E5E5E5").cgColor,UIColor(hexString: "#E5E5E5").cgColor])
            case .none:
                break
            }
        }
    }

}

