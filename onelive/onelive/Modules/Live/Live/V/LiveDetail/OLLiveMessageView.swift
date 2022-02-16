

import UIKit
import HandyJSON
import AttributedString

class OLLiveMessageView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 22.0
        tableView.rowHeight = UITableView.automaticDimension
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        tableView.register(OLLiveMessageCell.self, forCellReuseIdentifier: OLLiveMessageCell.description())
        return tableView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OLLiveMessageView: UITableViewDelegate,UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = OLLiveMessageCell(type: .winning)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

enum MessageType {
    case system,
         winning,
         user
}


class OLLiveMessageCell: UITableViewCell {
    
    init(type: MessageType) {
        super.init(style: .default, reuseIdentifier: OLLiveMessageCell.description())
        selectionStyle = .none
        backgroundColor = .clear
        switch type {
        case .system:
            textLabel?.textColor = UIColor(hexString: "#6BD8FF")
            textLabel?.snp.makeConstraints({ make in
                make.left.equalTo(8)
                make.right.equalTo(-8)
                make.top.equalTo(5)
                make.right.equalTo(-5)
                make.width.equalTo(250)
            })
        case .winning:
            contentView.addSubview(textView)
            textView.snp.makeConstraints({ make in
                    make.left.equalTo(8)
                    make.right.equalTo(-8)
                    make.top.equalTo(5)
                    make.right.equalTo(-5)
                    make.width.equalTo(250)
                })
        case .user:
            break
        }
        textLabel?.font = UIFont.fontRegular(12)
    }
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.attributed.text = "\(.view(systemLabel))"
        textView.sizeToFit()
        return textView
    }()
    
    
    lazy var systemLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 40, height: 18)
        label.addGradient([UIColor(hexString: "#A3F9FF").cgColor,UIColor(hexString: "#008FFF").cgColor], locations: [0, 1], startPoint: CGPoint(x: 0.50, y: 0.00), endPoint: CGPoint(x: 0.50, y: 1.00))
        label.setLayerCorner(radius: 4)
        return label
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
