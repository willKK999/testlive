

import UIKit
import SwiftUI



public enum BottomMenuType: Int {
    case agent = 0
    case payActivities 
    case gift
    case game
    case exit
    case message
}

public protocol OLLiveDetailBottomMenuViewDelegate: AnyObject {
    func bottomMenuView(didSelectedMenuType type:BottomMenuType)
}


class OLLiveDetailBottomMenuView: UIView {

    private var icons = [UIImage(named: "icon_live_agent"),
                         UIImage(named: "icon_live_pay_activities"),
                         UIImage(named: "icon_live_gift"),
                         UIImage(named: "icon_live_game"),
                         UIImage(named: "icon_live_exit")]
    
    weak open var delegate: OLLiveDetailBottomMenuViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(messageButton)
        messageButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.size.equalTo(CGSize(width: 93, height: 36))
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-2)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(46*5)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var messageButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 93, height: 36)
        button.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.30)
        button.layer.cornerRadius = 18
        button.layer.masksToBounds = true
        //message
        let messageIcon = UIImageView(image: UIImage(named: "icon_live_message"))
        button.addSubview(messageIcon)
        messageIcon.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(14)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
//        let label = UILabel()
//        label.text = "为你推荐"
//        label.textColor = UIColor.white
//        label.font = UIFont.fontRegular(9)
//        button.addSubview(label)
//        label.snp.makeConstraints { (make) in
//            make.centerY.equalToSuperview()
//            make.left.equalTo(arrowView.snp.right)
//        }
        button.addTarget(self, action: #selector(messageButtonClick), for: .touchUpInside)
        return button
    }()
    
    @objc func messageButtonClick() {
        if (delegate != nil) {
            delegate?.bottomMenuView(didSelectedMenuType: .message)
        }
    }
    
    lazy var collectionView: UICollectionView = {
        // 设置 flowLayout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        flowLayout.itemSize = CGSize(width: 36, height: 36)
        flowLayout.scrollDirection = .horizontal
        // 添加 collectionView，记得要设置 delegate 和 dataSource 的代理对象
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.contentMode = .right
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(OLLiveBottomMenuCell.self, forCellWithReuseIdentifier: OLLiveBottomMenuCell.description())
        return collectionView
    }()

}


extension OLLiveDetailBottomMenuView: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        icons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OLLiveBottomMenuCell.description(), for: indexPath) as! OLLiveBottomMenuCell
        cell.backgroundImageView.image = icons[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if (delegate != nil) {
            delegate?.bottomMenuView(didSelectedMenuType: BottomMenuType(rawValue: indexPath.row)!)
        }
    }
}



class OLLiveBottomMenuCell: UICollectionViewCell {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 18
        
        self.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
}
