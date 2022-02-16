

import UIKit

class OLMineNobleViewController: OLBaseViewController {

    var titles = ["遊侠","骑士","子爵","伯爵","侯爵","公爵","国王"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "贵族"
        self.navigationItem.rightBarButtonItem = rightButtonItem
        view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(oNavBarHeight)
        }
    }
    
    lazy var problemButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "icon_noble_problem"), for: .normal)
        button.sizeToFit()
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -5)
        button.addTarget(self, action: #selector(problemButtonClick), for: .touchUpInside)
        return button
    }()
    
    lazy var rightButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(customView: problemButton)
        return button
    }()

    lazy var topView: OLNobleTopView = {
        let view = OLNobleTopView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: oNavBarHeight))
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

extension OLMineNobleViewController {
    @objc func problemButtonClick() {
        OLNavigationManager.shared.pushToNobleProblemVC()
    }
}

extension OLMineNobleViewController: OLLiveCustomNavigationBarDelegate {
    func titlesView(didSelectedItemAt index: Int) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else{return}
            self.mainScrollView.contentOffset = CGPoint(x: Int(self.mainScrollView.width) * index, y: 0)
        }
    }
}
