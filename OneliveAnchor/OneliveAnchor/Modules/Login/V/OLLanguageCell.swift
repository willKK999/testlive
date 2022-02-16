

import UIKit

class OLLanguageCell: UITableViewCell {
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        textLabel?.font = UIFont.fontRegular(16)
        textLabel?.snp.makeConstraints({ make in
            make.left.equalTo(12)
            make.centerY.equalToSuperview()
        })
        contentView.addSubview(rightImageView)
        rightImageView.snp.makeConstraints({ make in
            make.right.equalTo(-20)
            make.size.equalTo(CGSize(width: 18, height: 18))
            make.centerY.equalToSuperview()
        })
    }
    
    lazy var rightImageView: UIImageView = {
        let view = UIImageView(image: OLImage.icon_right)
        view.isHidden = true
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        textLabel?.textColor = isSelected ? OLColors.hex_333333 : OLColors.hex_999999
        rightImageView.isHidden = !isSelected
    }

}
