

import UIKit

class OLSystemMessageCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        imageView?.contentMode = .scaleAspectFit
        imageView?.image = UIImage(named: "icon_msg_email")
        imageView?.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(22)
            make.left.equalTo(12)
            make.size.equalTo(CGSize(width: 32, height: 32))
        })
        textLabel?.font = UIFont.fontRegular(14)
        textLabel?.textColor = UIColor(hexString: "#333333")
        textLabel?.snp.makeConstraints({ make in
            make.top.equalTo(imageView!.snp.top)
            make.left.equalTo(imageView!.snp.right).offset(8)
            make.height.equalTo(20)
        })
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        })
        
        contentView.addSubview(contentTextView)
        contentTextView.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(44)
            make.left.equalTo(imageView!.snp.right).offset(8)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview()
        })
        
    }
    
    lazy var dateLabel: UILabel =  {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .fontRegular(10)
        label.textColor = UIColor(hexString: "#333333")
        label.text = "5月7日 01:32"
        return label
    }()
    
    lazy var contentTextView: UIView = {
        let view = UIView()
        view.addSubview(contentLabel)
        view.setLayerCorner(radius: 6)
        view.backgroundColor = UIColor(hexString: "#FAFAFA")
        contentLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(10)
            make.right.bottom.equalToSuperview().offset(-10)
        }
        return view
    }()
    
    lazy var contentLabel: UILabel =  {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .fontRegular(10)
        label.textColor = UIColor(hexString: "#666666")
        label.numberOfLines = 0
        label.text = "尊敬的VIP用户您好，接获银行升级维护通知，\n届时会影响提现下发业务，银行维护时段如下，\n请知悉： \n中国银行：2021年09月09日01:00-2021年09月09日01:00 \n交通银行：2021年09月09日01:00-2021年09月09日01:00 \n农业银行：2021年09月09日01:00-2021年09月09日01:00"
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
