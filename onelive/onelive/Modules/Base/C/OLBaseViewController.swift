

import UIKit
import Toast_Swift
class OLBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hexString: "#FAFAFA")
    }
    
    func showLoading(_ text: String? = nil) {
        if text != nil {
            OLProgressHUD.show(withStatus: text!)
        }else {
            OLProgressHUD.show()
        }
    }
    
    func hideLoading() {
        OLProgressHUD.hide()
    }

    func showToast(_ message: String?) {
        guard let msg = message else {
            return
        }
        OLProgressHUD.showMessage(msg)
    }

}
