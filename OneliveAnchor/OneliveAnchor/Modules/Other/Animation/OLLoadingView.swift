

import UIKit
import Lottie
import SnapKit

class OLLoadingView: UIView {

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: oScreenHeight))
        addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
    }
    
    lazy var loadingView: AnimationView = {
        let animationView = AnimationView(name: "loading")
        animationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let keyPathA = AnimationKeypath(keypath: "**.circle_A.Fill 1.Color")
        let orangeA = Color(r: (255/255), g: (84/255), b: (168/255), a: 1)
        let orangeColorValueProviderA = ColorValueProvider(orangeA)
        animationView.setValueProvider(orangeColorValueProviderA, keypath: keyPathA)
        let keyPathB = AnimationKeypath(keypath: "**.circle_B.Fill 1.Color")
        let orangeB = Color(r: (255/255), g: (84/255), b: (168/255), a: 1)
        let orangeColorValueProviderB = ColorValueProvider(orangeB)
        animationView.setValueProvider(orangeColorValueProviderB, keypath: keyPathB)
        let keyPathC = AnimationKeypath(keypath: "**.circle_C.Fill 1.Color")
        let orangeC = Color(r: (255/255), g: (84/255), b: (168/255), a: 1)
        let orangeColorValueProviderC = ColorValueProvider(orangeC)
        animationView.setValueProvider(orangeColorValueProviderC, keypath: keyPathC)
        animationView.loopMode = .loop
        animationView.play()
        return animationView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static var loading: OLLoadingView?
    
    static func show() {
        loading = OLLoadingView()
        oKeyWindow()?.addSubview(loading!)
        UIView.animate(withDuration: 0.25) {
            loading!.backgroundColor = UIColor(hexString: "#000000", alpha: 0.2)
        }
    }

    static func hide() {
        if loading != nil {
            UIView.animate(withDuration: 0.25, animations: {
                loading!.backgroundColor = UIColor(hexString: "#000000", alpha: 0.0)
            }, completion: {_ in 
                loading!.removeFromSuperview()
            })
        }
    }
}
