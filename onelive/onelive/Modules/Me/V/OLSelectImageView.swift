

import UIKit

class OLSelectImageView: UIView {
    
    var titles = ["拍照","从手机相册相册选择","取消"]
    let top = UITapGestureRecognizer()
    
    init() { //titles: [String]?)
        super.init(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: oScreenHeight))
        addSubview(bgView)
        top.addTarget(self, action: #selector(dismissView))
        bgView.addGestureRecognizer(top)
        addSubview(tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var bgView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: oScreenHeight))
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: oScreenHeight, width: oScreenWidth, height: CGFloat(self.titles.count)*55.0 + oSafeAreaBottomHeight()), style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        tableView.separatorColor = UIColor(hexString: "#F5F5F5")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.register(OLCenterTitleCell.self, forCellReuseIdentifier: OLCenterTitleCell.description())
        return tableView
    }()
    
    func show() {
        oKeyWindow()?.addSubview(self)
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let self = self else{return}
            self.backgroundColor = UIColor(hexString: "#000000", alpha: 0.4)
            self.tableView.y = oScreenHeight - (CGFloat(self.titles.count)*55.0 + oSafeAreaBottomHeight())
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.25, animations: { [weak self] in
            guard let self = self else{return}
            self.tableView.y = oScreenHeight
            self.backgroundColor = UIColor(hexString: "#000000", alpha: 0.0)
        }, completion: { [weak self] (finished) in
            guard let self = self else{return}
            self.removeFromSuperview()
        })
    }
    
    @objc func dismissView(_ sender:UITapGestureRecognizer) {
        let touchesPoint = sender.location(in: self)
        if !tableView.frame.contains(touchesPoint) {
            dismiss()
        }
    }
}

extension OLSelectImageView: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        55
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OLCenterTitleCell.description(), for: indexPath) as! OLCenterTitleCell
        cell.textLabel?.text = titles[indexPath.row]
        cell.isCancel = ((titles.count - 1) == indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if (titles.count - 1) == indexPath.row {
            self.dismiss()
        }
    }
}


