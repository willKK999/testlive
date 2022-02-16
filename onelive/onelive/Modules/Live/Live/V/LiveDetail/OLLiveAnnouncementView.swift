

import UIKit

class OLLiveAnnouncementView: UIView {

    let top = UITapGestureRecognizer()
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: oScreenHeight))
        addSubview(bgView)
        top.addTarget(self, action: #selector(dismissView))
        bgView.addGestureRecognizer(top)
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var bgView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: oScreenHeight))
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 260, height: 340))
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(30)
            make.left.equalTo(116)
            make.height.equalTo(30)
        }
        view.addSubview(textImageView)
        textImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.left.equalTo(30)
            make.width.equalTo(203)
            make.height.equalTo(170)
        }
        return view
    }()
    
    lazy var bgImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "icon_announcement_bg"))
        return view
    }()
    
    lazy var titleLabel: UILabel =  {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = .fontSemibold(22)
        titleLabel.textColor = UIColor(hexString: "#FFFFFF")
        titleLabel.text = "公告"
        return titleLabel
    }()
    
    lazy var textImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "icon_announcement_text"))
        return view
    }()
    
    @objc func dismissView(_ sender:UITapGestureRecognizer) {
        let touchesPoint = sender.location(in: self)
        if !contentView.frame.contains(touchesPoint) {
            dismiss()
        }
    }
    
    func show() {
        oKeyWindow()?.addSubview(self)
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let self = self else{return}
            self.backgroundColor = UIColor(hexString: "#000000", alpha: 0.4)
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.25, animations: { [weak self] in
            guard let self = self else{return}
            self.backgroundColor = UIColor(hexString: "#000000", alpha: 0.0)
        }, completion: { [weak self] (finished) in
            guard let self = self else{return}
            self.removeFromSuperview()
        })
    }
}
