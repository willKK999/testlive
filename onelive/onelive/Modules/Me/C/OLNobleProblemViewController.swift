

import UIKit

class OLNobleProblemViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "FAQ"
        view.backgroundColor = .white
        view.addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(12)
            make.right.equalTo(-12)
        }
    }
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        let attrString = NSMutableAttributedString(string: "如何更换贵族 \n\n1．若已开通贵族，可继续开通更高等级的贵族，但不能开通低于当前等级的贵族。例如：您已是 【 公爵 】，您可开通 【 国王 】 ，但不能开通 【 侯爵 】 。一旦成功开通 【 国王 】 ，您将立刻获得 【 国王 】 的所有特权，原有 【 公爵 】 身份将失效。 \n\n2．贵族身份有效期内，可通过续费优惠价延长当前贵族有效期。 \n\n3．若贵族身份已过期，则无法享受续费优惠，可重新开通任意等级贵族。")
        // attr1
        let strSubAttr1: [NSAttributedString.Key : Any] = [.font: UIFont.fontRegular(14),
        .foregroundColor: UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00),
        ]
        attrString.addAttributes(strSubAttr1, range: NSRange(location: 0, length: 6))
        // attr2
        let strSubAttr2: [NSAttributedString.Key : Any] = [.font: UIFont.fontRegular(12),
        .foregroundColor: UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00),
        ]
        attrString.addAttributes(strSubAttr2, range: NSRange(location: 6, length: 1))
        // attr3
        let strSubAttr3: [NSAttributedString.Key : Any] = [.font: UIFont.fontRegular(12),
        .foregroundColor: UIColor(red: 0.40, green: 0.40, blue: 0.40, alpha: 1.00),
        ]
        attrString.addAttributes(strSubAttr3, range: NSRange(location: 7, length: 199))
        label.attributedText = attrString
        return label
    }()

}
