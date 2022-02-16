

import UIKit

class OLCenterTitleCell: UITableViewCell {
    
    var isCancel: Bool! {
        didSet {
            if isCancel {
                textLabel?.textColor = UIColor(hexString: "#666666")
            }else {
                textLabel?.textColor = UIColor(hexString: "#638DEC")
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel?.font = UIFont.fontMedium(16)
        textLabel?.snp.makeConstraints({ make in
            make.center.equalToSuperview()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
