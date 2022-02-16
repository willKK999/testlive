

import UIKit
import Toast_Swift
import Lottie

class OLBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hexString: "#FAFAFA")
    }
    func showLoading() {
        OLLoadingView.show()
    }
    
    func hideLoading() {
        OLLoadingView.hide()
    }

}
