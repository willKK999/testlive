

import UIKit
import SnapKit
import Kingfisher

class OLLiveDetailViewController: OLBaseViewController {

    var live: OLLiveItemModel! {
        didSet {
            if let url = URL(string: live.studioBackground ?? "") {
                backgroundImageView.kf.setImage(with: url, placeholder: UIImage(named: "live"))
            }
        }
    }
    var roomDetail: OLRoomDetailModel?
    let recommendedAnchorVC = OLRecommendedAnchorViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    //加载数据
    func loadData() {
        OLAPIManager.shared.getRoomDetail(studioNum: live.studioNum!) { [weak self]  result in
            guard let self = self else {return}
            if result.isSuccess {
                if let model = result.data {
                    self.roomDetail = model
                    self.setupUI()
                }
            }
        }
        OLAPIManager.shared.getAnchorInfo(anchorId: live.anchorId) { [weak self]  result in
//            guard let self = self else {return}
//            if result.isSuccess {
//                if let model = result.data {
//
//
//                }
//            }
        }
         OLAPIManager.shared.checkBanned(studioNum: live.studioNum!) { result in
             if result.isSuccess {
                 if let state = result.data,state == true {
                 }
             }
         }
    }
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "live"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    func setupUI() {
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(topMenuView)
        topMenuView.snp.makeConstraints { make in
            make.top.equalTo(oStatusBarHeight)
            make.left.right.equalToSuperview()
            make.height.equalTo(115)
        }
        
        view.addSubview(winningView)
        winningView.snp.makeConstraints { make in
            make.top.equalTo(topMenuView.snp.bottom).offset(45)
            make.left.equalTo(12)
            make.size.equalTo(CGSize(width: 340, height: 30))
        }
        
        view.addSubview(centerMenuView)
        centerMenuView.snp.makeConstraints { make in
            make.top.equalTo(topMenuView.snp.bottom).offset(161)
            make.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 54, height: 60))
        }
        
        view.addSubview(messageView)
        
        view.addSubview(contactBGView)
        contactBGView.snp.makeConstraints { make in
            make.top.equalTo(centerMenuView.snp.bottom).offset(166)
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 77, height: 20))
        }
        
        view.addSubview(bottomMenuView)
        bottomMenuView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-(12.0 + oSafeAreaBottomHeight()))
            make.left.right.equalToSuperview()
            make.height.equalTo(36)
        }
        
        messageView.snp.makeConstraints { make in
            make.bottom.equalTo(bottomMenuView.snp.top).offset(-20)
            make.left.equalTo(12)
            make.size.equalTo(CGSize(width: 266, height: 266))
        }
        //推荐主播
        addChild(recommendedAnchorVC)
        recommendedAnchorVC.live = live
        recommendedAnchorVC.view.frame = view.bounds
        view.addSubview(recommendedAnchorVC.view)
        
        //公告
        let announcementView = OLLiveAnnouncementView()
        announcementView.show()
    }
    
    lazy var topMenuView: OLLiveDetailTopMenuView = {
        let view = OLLiveDetailTopMenuView()
        //主播信息
        view.anchorInfoView.liveAnchor = self.roomDetail!.liveAnchorVO
        view.anchorInfoView.addTarget(self, action: #selector(anchorInfoButtonClick), for: .touchUpInside)
        view.anchorInfoView.followButton.addTarget(self, action: #selector(followButtonClick), for: .touchUpInside)
        //在线观众
        view.onlineView.onlineList = self.roomDetail?.onlineList;
        view.onlineView.audienceButton.setTitle(self.roomDetail?.onlineNum ?? "0", for: .normal)
        view.onlineView.audienceButton.addTarget(self, action: #selector(onlineAudienceButtonClick), for: .touchUpInside)
        
        //推荐主播
        view.recommendedView.titleButton.addTarget(target, action: #selector(liveRecommendedButtonClick), for: .touchUpInside)
        //主播名片
        view.recommendedView.liveButton.addTarget(self, action: #selector(liveCardButtonClick), for: .touchUpInside)
        
        view.contributionButton.addTarget(self, action: #selector(contributionButtonClick), for: .touchUpInside)
        view.watchButton.addTarget(self, action: #selector(watchButtonClick), for: .touchUpInside)
        
        return view
    }()
    
    lazy var winningView: OLWinningAnnounceView = {
        let view = OLWinningAnnounceView(frame: CGRect(x: 0, y: 0, width: 340, height: 30))
        return view
    }()
    
    lazy var messageView: OLLiveMessageView = {
        let view = OLLiveMessageView(frame: CGRect(x: 0, y: 0, width: 266, height: 266))
        return view
    }()
    
    lazy var contactBGView: UIView = {
        let view = UIView(frame:CGRect(x: 0, y: 0, width: 77, height: 20))
        view.roundCorners([.topRight,.bottomRight], radius: 100)
        view.addGradient([UIColor(hexString: "#FF54EE").cgColor,UIColor(hexString: "#FFD7B9").cgColor], locations: [0, 1], startPoint: CGPoint(x: -0.05, y: 0.13), endPoint: CGPoint(x: 0.95, y: 0.13))
        view.addSubview(contactLabel)
        contactLabel.snp.makeConstraints { make in
            make.left.equalTo(12)
            make.top.right.bottom.equalToSuperview()
        }
        return view
    }()
    
    lazy var contactLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.fontRegular(11)
        label.textColor = UIColor.white
        label.text = "有人@了你"
        return label
    }()
    
    lazy var centerMenuView: OLLiveDetailCenterMenuView = {
        let view = OLLiveDetailCenterMenuView()
        //游戏
        if let url = URL(string: self.roomDetail?.gameIcon ?? "") {
            view.gameButton.kf.setImage(with: url, for: .normal, placeholder: UIImage(named: "live_game"))
        }
        //时间
        view.timeLabel.text = String(self.roomDetail?.endTime ?? 0) + "秒"
        return view
    }()
    
    lazy var bottomMenuView: OLLiveDetailBottomMenuView = {
        let view = OLLiveDetailBottomMenuView()
        view.delegate = self
        return view
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        oPrint(self.title as Any)
    }
}

extension OLLiveDetailViewController: OLLiveDetailBottomMenuViewDelegate {
    
    @objc func anchorInfoButtonClick() {
        let anchorInfoVC = OLAnchorInfoViewController()
        anchorInfoVC.live = live
        anchorInfoVC.roomDetail = roomDetail
        anchorInfoVC.reportButton.addTarget(self, action: #selector(reportButtonClick), for: .touchUpInside)
        anchorInfoVC.modalPresentationStyle = .custom
        self.navigationController?.present(anchorInfoVC, animated: true, completion: nil)
    }
    
    @objc func reportButtonClick() {
        self.navigationController?.dismiss(animated: true)
        let alertController = UIAlertController()
        alertController.view.tintColor = UIColor(hexString: "#638DEC")
        let title1Action = UIAlertAction(title: "政治谣言", style: .default) { (action) in
            
        }
        let title2Action = UIAlertAction(title: "色情低谷", style: .default) { (action) in
            
        }
        let title3Action = UIAlertAction(title: "商业广告", style: .default) { (action) in
            
        }
        let title4Action = UIAlertAction(title: "侮辱谩骂", style: .default) { (action) in
            
        }
        alertController.addAction(title1Action)
        alertController.addAction(title2Action)
        alertController.addAction(title3Action)
        alertController.addAction(title4Action)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        cancelAction.setValue(UIColor(hexString: "#666666"), forKey: "titleTextColor")
        alertController.addAction(cancelAction)
        self.navigationController?.present(alertController, animated: true, completion: nil)
    }
    
    @objc func followButtonClick() {
        self.showLoading()
        OLAPIManager.shared.followUser(isCancel: roomDetail!.liveAnchorVO!.isFocus,userId: roomDetail!.userId!) { [weak self]  result in
            guard let self = self else {return}
            self.hideLoading()
            if result.isSuccess {
                self.roomDetail?.liveAnchorVO?.isFocus = !(self.roomDetail?.liveAnchorVO?.isFocus)!
            }
            self.showToast(result.msg)
        }
    }
    
    @objc func liveRecommendedButtonClick() {
        recommendedAnchorVC.hidden = false
    }
    
    @objc func liveCardButtonClick() {
        let anchorCardVC = OLAnchorCardViewController()
        anchorCardVC.roomDetail = roomDetail
        anchorCardVC.modalPresentationStyle = .custom
        self.navigationController?.present(anchorCardVC, animated: true, completion: nil)
    }
    
    @objc func onlineAudienceButtonClick() {
        let onlineAudienceVC = OLOnlineAudienceViewController()
        onlineAudienceVC.live = live
        onlineAudienceVC.roomDetail = roomDetail
        onlineAudienceVC .modalPresentationStyle = .custom
        self.navigationController?.present(onlineAudienceVC, animated: true, completion: nil)
    }
    
    @objc func contributionButtonClick() {
        let contributionListVC = OLContributionListViewController()
        contributionListVC.live = live
        contributionListVC.modalPresentationStyle = .custom
        self.navigationController?.present(contributionListVC, animated: true, completion: nil)
    }
    
    @objc func watchButtonClick() {
        let watchListVC = OLWatchListViewController()
        watchListVC.live = live
        watchListVC.modalPresentationStyle = .custom
        self.navigationController?.present(watchListVC, animated: false, completion: nil)
    }
    
    func bottomMenuView(didSelectedMenuType type: BottomMenuType) {
        switch type {
        case .agent:
            self.navigationController?.popViewController(animated: true)
        case .payActivities:
            let payActivitiesVC = OLPayActivitiesViewController()
            payActivitiesVC.modalPresentationStyle = .custom
            self.navigationController?.present(payActivitiesVC, animated: true, completion: nil)
        case .gift:
            self.navigationController?.popViewController(animated: true)
        case .game:
            let studioGamesVC = OLStudioGamesViewController()
            studioGamesVC.bottomView.rechargeButton.addTarget(self, action: #selector(rechargeButtonClick), for: .touchUpInside)
            studioGamesVC.modalPresentationStyle = .custom
            self.navigationController?.present(studioGamesVC, animated: true, completion: nil)
        case .exit:
            self.navigationController?.popViewController(animated: true)
        case .message:
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func rechargeButtonClick() {
        self.navigationController?.dismiss(animated: true)
        let  alertController =  UIAlertController(title: "提示" ,
                                                   message: "系统检测到你尚未绑定手机号 请先绑定手机号以完成充值" , preferredStyle: .alert)
        let  cancelAction =  UIAlertAction(title: "取消" , style: .cancel, handler:  nil )
        cancelAction.setValue(UIColor(hexString: "#999999"), forKey: "titleTextColor")
        let  okAction =  UIAlertAction(title:  "立即绑定" , style: . default , handler: {
            action  in
            print ( "点击了确定" )
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.navigationController?.present(alertController, animated:  true , completion:  nil )
    }

}
