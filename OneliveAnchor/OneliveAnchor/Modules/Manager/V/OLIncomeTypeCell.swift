

import UIKit

class OLIncomeTypeCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        imageView?.contentMode = .scaleAspectFit
        imageView?.snp.makeConstraints({ make in
            make.left.equalTo(25)
            make.size.equalTo(CGSize(width: 20, height: 20))
            make.centerY.equalToSuperview()
        })
        textLabel?.font = OLFont.PingFang_Medium13
        textLabel?.textColor = OLColors.hex_333333
        textLabel?.snp.makeConstraints({ make in
            make.left.equalTo(imageView!.snp.right).offset(10)
            make.centerY.equalToSuperview()
        })
        detailTextLabel?.text = "¥10000.00"
        detailTextLabel?.font = OLFont.PingFang_Medium13
        detailTextLabel?.textColor = OLColors.hex_333333
        detailTextLabel?.snp.makeConstraints({ make in
            make.right.equalTo(-25)
            make.centerY.equalToSuperview()
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
