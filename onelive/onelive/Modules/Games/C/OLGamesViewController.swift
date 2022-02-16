

import UIKit

class OLGamesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(unattentionView)
        unattentionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    lazy var unattentionView: OLLiveUnattentionView = {
         let unattentionView = OLLiveUnattentionView()
        return unattentionView
    }()
    
}
