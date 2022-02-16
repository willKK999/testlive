

import UIKit

class OLMinePWRecordViewController: UIViewController {
    
    var titles = ["充值记录","提现记录"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "充提记录"
        view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(oNavBarHeight)
        }
        view.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(oNavBarHeight)
            make.left.right.bottom.equalToSuperview()
        }
        
        addChildVC()
    }
    
    func addChildVC() {
        //充值记录
        let payRecordsVC = OLRecordPageViewController(style: .pay)
        self.addChild(payRecordsVC)
        payRecordsVC.view.frame = mainScrollView.bounds
        mainScrollView.addSubview(payRecordsVC.view)
        //提现记录
        let withdrawalRecordsVC = OLRecordPageViewController(style: .withdrawal)
        self.addChild(withdrawalRecordsVC)
        withdrawalRecordsVC.view.frame = CGRect(x: oScreenWidth, y: 0, width: oScreenWidth, height: mainScrollView.bounds.height)
        mainScrollView.addSubview(withdrawalRecordsVC.view)
    }
    
    lazy var topView: OLMineRecordTopView = {
        let view = OLMineRecordTopView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: oNavBarHeight))
        view.titles = titles
        view.delegate = self
        return view
    }()
    
    lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect.zero)
        scrollView.bounces = false
        scrollView.delegate = topView
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: oScreenWidth * CGFloat(titles.count), height: 0)
        return scrollView
    }()

}

extension OLMinePWRecordViewController: OLLiveCustomNavigationBarDelegate {
    func titlesView(didSelectedItemAt index: Int) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else{return}
            self.mainScrollView.contentOffset = CGPoint(x: Int(self.mainScrollView.width) * index, y: 0)
        }
    }
}
