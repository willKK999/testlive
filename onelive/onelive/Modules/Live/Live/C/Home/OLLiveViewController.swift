

import UIKit
import SnapKit

class OLLiveViewController: UIViewController {
    
    var columns: Array<OLColumnModel> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OLAPIManager.shared.getColumnList { [weak self] (result) in
            guard let self = self else {return}
            if result.isSuccess {
                self.columns = result.data!
                self.setupUI()
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override  func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let vc = OLLiveDetailParentViewController()
        OLNavigationManager.shared.mainNavControllerPushVC(vc, animated: true)
    }
    
    func setupUI() {
        view.addSubview(liveNavigationBar)
        liveNavigationBar.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(oStatusAndNavBarHeight)
        }
        
        view.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(oStatusAndNavBarHeight)
            make.left.right.bottom.equalToSuperview()
        }
        
        addChildViewControllers()
    }
    
    func addChildViewControllers() {
        /**
         关注  推荐 热门 游戏 附近
         @"OLLiveFollowViewController",
         @"OLLiveRecommendedViewController",
         @"OLLiveHotViewController",
         @"OLLiveGameViewController",
         @"OLLiveNearViewController"
         */
        for i in 0..<columns.count {
            let model = columns[i]
            var vc = UIViewController()
            switch model.columnCode {
            case "recommend":
                //推荐
                vc = OLLiveRecommendedViewController()
                break
            case "focus":
                //关注
                vc = OLLiveFollowViewController()
                break
            case "hot":
                //热门
                vc = OLLiveHotViewController()
                break
            case "nearby":
                //附近
                vc = OLLiveNearViewController()
                break
            default:
                //其他
                vc = OLLiveGameViewController()
                break
            }
            self.addChild(vc)
            vc.view.frame = CGRect(x: oScreenWidth * CGFloat(i), y: 0, width: oScreenWidth, height: self.mainScrollView.height)
            self.mainScrollView.addSubview(vc.view)
        }
    }
    
    //MARK: lazy
    lazy var liveNavigationBar: OLLiveCustomNavigationBar = {
        let navBar = OLLiveCustomNavigationBar(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: oStatusAndNavBarHeight))
        navBar.delegate = self
        navBar.columns = columns
        return navBar
    }()
    
    lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: oStatusAndNavBarHeight, width: oScreenWidth, height: CGFloat(view.frame.size.height - oStatusAndNavBarHeight - oNavBarHeight)))
        scrollView.bounces = false
        scrollView.delegate = liveNavigationBar
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: scrollView.width * CGFloat(columns.count), height: scrollView.height)
        return scrollView
    }()

}

extension OLLiveViewController: OLLiveCustomNavigationBarDelegate {
    func titlesView(didSelectedItemAt index: Int) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else{return}
            self.mainScrollView.contentOffset = CGPoint(x: Int(self.mainScrollView.width) * index, y: 0)
        }
    }
}
