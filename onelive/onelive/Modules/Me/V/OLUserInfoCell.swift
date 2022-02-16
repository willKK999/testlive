

import UIKit

class OLUserInfoCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imageView?.contentMode = .scaleAspectFit
        imageView?.image = UIImage(named: "avatar")
        imageView?.snp.makeConstraints({ make in
            make.left.equalTo(12)
            make.size.equalTo(CGSize(width: 54, height: 54))
            make.centerY.equalToSuperview()
        })
        textLabel?.text = "精致快三"
        textLabel?.font = UIFont.fontMedium(14)
        textLabel?.textColor = UIColor(hexString: "#333333")
        textLabel?.snp.makeConstraints({ make in
            make.top.equalTo(12)
            make.left.equalTo(imageView!.snp.right).offset(10)
        })
        addSubview(sexImageView)
        sexImageView.snp.makeConstraints({ make in
            make.top.equalTo(textLabel!.snp.bottom).offset(6)
            make.left.equalTo(imageView!.snp.right).offset(10)
            make.size.equalTo(CGSize(width: 12, height: 12))
        })
        addSubview(levelImageView)
        levelImageView.snp.makeConstraints({ make in
            make.top.equalTo(textLabel!.snp.bottom).offset(6)
            make.left.equalTo(sexImageView.snp.right).offset(10)
            make.size.equalTo(CGSize(width: 28, height: 12))
        })
        addSubview(remarkLabel)
        remarkLabel.snp.makeConstraints({ make in
            make.top.equalTo(sexImageView.snp.bottom).offset(5)
            make.left.equalTo(imageView!.snp.right).offset(10)
        })
    }
    
    lazy var sexImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_man"))
        return imageView
    }()
    
    lazy var levelImageView: UIImageView = {
        let imageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 28, height: 13))
        imageView.image = UIImage(named: "icon_level_w")
        return imageView
    }()
    
    lazy var remarkLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.fontRegular(10)
        label.textColor = UIColor(hexString: "#999999")
        label.text = "TA好像忘记了签名了"
        return label
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

        // Configure the view for the selected state
    }

}
