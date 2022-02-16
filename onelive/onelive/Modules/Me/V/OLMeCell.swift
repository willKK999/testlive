
import UIKit

class OLMeCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imageView?.contentMode = .scaleAspectFit
        imageView?.image = UIImage(named: "icon_me_setting")
        imageView?.snp.makeConstraints({ make in
            make.left.equalTo(12)
            make.size.equalTo(CGSize(width: 20, height: 20))
            make.centerY.equalToSuperview()
        })
        textLabel?.text = "设置"
        textLabel?.font = UIFont.fontMedium(13)
        textLabel?.textColor = UIColor(hexString: "#333333")
        textLabel?.snp.makeConstraints({ make in
            make.left.equalTo(imageView!.snp.right).offset(10)
            make.centerY.equalToSuperview()
        })
        addSubview(arrowView)
        arrowView.snp.makeConstraints({ make in
            make.right.equalTo(-8)
            make.size.equalTo(CGSize(width: 16, height: 16))
            make.centerY.equalToSuperview()
        })
    }
    
    lazy var arrowView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "arrow_right_6"))
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

        // Configure the view for the selected state
    }
}
