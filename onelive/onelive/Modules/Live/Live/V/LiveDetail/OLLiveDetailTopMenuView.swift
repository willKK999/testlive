

import UIKit

class OLLiveDetailTopMenuView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(anchorInfoView)
        anchorInfoView.snp.makeConstraints { make in
            make.top.equalTo(6)
            make.left.equalTo(12)
            make.size.equalTo(CGSize(width: 148, height: 32))
        }
        
        addSubview(contributionButton)
        contributionButton.snp.makeConstraints { make in
            make.top.equalTo(anchorInfoView.snp.bottom).offset(10)
            make.left.equalTo(12)
            make.size.equalTo(CGSize(width: 46, height: 18))
        }
        
        addSubview(watchButton)
        watchButton.snp.makeConstraints { make in
            make.top.equalTo(anchorInfoView.snp.bottom).offset(10)
            make.left.equalTo(contributionButton.snp.right).offset(10)
            make.size.equalTo(CGSize(width: 61, height: 18))
        }
        
        addSubview(onlineView)
        onlineView.snp.makeConstraints { make in
            make.left.equalTo(anchorInfoView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalTo(anchorInfoView)
            make.height.equalTo(30)
        }
        
        addSubview(recommendedView)
        recommendedView.snp.makeConstraints { make in
            make.top.equalTo(anchorInfoView.snp.bottom).offset(10)
            make.right.equalToSuperview()
            make.width.equalTo(68)
            make.height.equalTo(66)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var anchorInfoView: OLAnchorInfoView = {
        let view = OLAnchorInfoView()
        return view
    }()
    //贡献榜
    lazy var contributionButton: UIButton = {
        let button = OLReLayoutButton(style: .image_Text, space: 5)
        button.setImage(UIImage(named: "icon_contribution_list"), for: .normal)
        button.setTitle("排行", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.fontRegular(9)
        button.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.20)
        button.layer.cornerRadius = 9
        return button
    }()
    //守护榜
    lazy var watchButton: UIButton = {
        let button = OLReLayoutButton(style: .image_Text, space: 5)
        button.setImage(UIImage(named: "icon_watch_list"), for: .normal)
        button.setTitle("999999", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.fontRegular(9)
        button.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.20)
        button.layer.cornerRadius = 9
        return button
    }()
    
    lazy var onlineView: OLOnlineView = {
        let view = OLOnlineView()
        return view
    }()
    
    lazy var recommendedView: OLRecommendedView = {
        let view = OLRecommendedView()
        return view
    }()
}
