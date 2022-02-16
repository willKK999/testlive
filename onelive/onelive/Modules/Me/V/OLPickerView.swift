

import UIKit

public enum PickerStyle {
    /// 性别
    case gender
    /// 时间
    case date
    /// 地址
    case address
    /// 情感
    case marriage
    ///职业
    case job
}

typealias  StingVoidBlock = (_ answer: String) -> Void

class OLPickerView: UIView {
    
    private var callBackBlock: StingVoidBlock?
    
    private var style: PickerStyle!
    
    var genderTitles = ["男","女"]
    var marriageTitles = ["恋爱","单身","未婚","已婚","保密"]
    var jobTitles = ["歌手","化妆师","演员","模特","空姐","摄影师","厨师","程序员"]
    lazy var address: Array<String> = {
        var address: Array<String> = []
        let filePath = Bundle.main.path(forResource:"AreaCodeList", ofType: "json")
        var data: Data?
        if let filePath = filePath {
            data = try? Data.init(contentsOf: URL.init(fileURLWithPath: filePath))
        }
        guard let json = String(data: data!, encoding: String.Encoding.utf8) else {
            return address
        }
        guard let listModel = OLAreaCodeListModel.deserialize(from: json) else {
            return address
        }
        for model in listModel.list {
            address.append(model.op_name)
        }
        return address
    }()
    
    var selectedTitle: String = ""
    let top = UITapGestureRecognizer()
    
    init(style: PickerStyle,completion:@escaping StingVoidBlock) {
        super.init(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: oScreenHeight))
        
        addSubview(bgView)
        top.addTarget(self, action: #selector(dismissView))
        bgView.addGestureRecognizer(top)
        
        self.style = style
        self.callBackBlock = completion
        switch style {
        case .date:
            contentView.addSubview(datePicker)
            datePicker.snp.makeConstraints { (make) in
                make.top.equalTo(topView.snp.bottom)
                make.left.right.equalToSuperview()
                make.height.equalTo(220.0)
            }
        default:
            contentView.addSubview(pickerView)
            pickerView.snp.makeConstraints { (make) in
                make.top.equalTo(topView.snp.bottom)
                make.left.right.equalToSuperview()
                make.height.equalTo(220.0)
            }
        }
        
        backgroundColor = UIColor(hexString: "#000000", alpha: 0.4)
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(262.0 )
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: lazy
    lazy var bgView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: oScreenHeight))
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: oScreenHeight, width: oScreenWidth, height: 262 + oSafeAreaBottomHeight()))
        view.backgroundColor = .white
        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(42)
        }
        return view
    }()
    
    lazy var topView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 42))
        view.backgroundColor = UIColor(hexString: "#F5F5F5")
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.left.equalTo(12)
            make.centerY.equalToSuperview()
        }
        view.addSubview(doneButton)
        doneButton.snp.makeConstraints { make in
            make.right.equalTo(-12)
            make.centerY.equalToSuperview()
        }
        return view
    }()
    lazy var cancelButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = UIFont.fontMedium(14)
        button.setTitle("取消", for: .normal)
        button.setTitleColor(UIColor(hexString: "#333333"), for: .normal)
        button.addTarget(self, action: #selector(cancelButtonClick), for:.touchUpInside)
        return button
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = UIFont.fontMedium(14)
        button.setTitle("确定", for: .normal)
        button.setTitleColor(UIColor(hexString: "#333333"), for: .normal)
        button.addTarget(self, action: #selector(doneButtonClick), for:.touchUpInside)
        return button
    }()
    
    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 220))
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        return picker
    }()
    
    lazy var myDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 220))
        datePicker.datePickerMode = .date
        datePicker.setDate(NSDate() as Date, animated: true)
        datePicker.maximumDate = Date()
        datePicker.backgroundColor = UIColor.white
        datePicker.locale = NSLocale(localeIdentifier: "zh_CN") as Locale
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        return datePicker
    }()
    
}

extension OLPickerView{
    
    func show() {
        oKeyWindow()?.addSubview(self)
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let self = self else{return}
            self.backgroundColor = UIColor(hexString: "#000000", alpha: 0.4)
            self.contentView.y = oScreenHeight - (262 + oSafeAreaBottomHeight())
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.25, animations: { [weak self] in
            guard let self = self else{return}
            self.contentView.y = oScreenHeight
            self.backgroundColor = UIColor(hexString: "#000000", alpha: 0.0)
        }, completion: { [weak self] (finished) in
            guard let self = self else{return}
            self.removeFromSuperview()
        })
    }
    
    @objc func dismissView(_ sender:UITapGestureRecognizer) {
        let touchesPoint = sender.location(in: self)
        if !contentView.frame.contains(touchesPoint) {
            dismiss()
        }
    }
    
    @objc func cancelButtonClick() {
        self.dismiss()
    }
    
    @objc func doneButtonClick() {
        if callBackBlock != nil {
            if style == .date{
                callBackBlock!(myDateFormatter.string(from: datePicker.date))
            }else {
                callBackBlock!(selectedTitle)
            }
        }
        self.dismiss()
    }
}


extension OLPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    /// 返回列
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch style {
        case .address:
            return 1
        default:
            return 1
        }
    }
    /// 返回对应列的行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch style {
        case .address:
            return address.count
        case .gender:
            return genderTitles.count
        case .marriage:
            return marriageTitles.count
        case .job:
            return jobTitles.count
        default:
            return 0
        }
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch style {
        case .address:
            self.selectedTitle = address.first!
            return address[row]
        case .gender:
            self.selectedTitle = genderTitles.first!
            return genderTitles[row]
        case .marriage:
            self.selectedTitle = marriageTitles.first!
            return marriageTitles[row]
        case .job:
            self.selectedTitle = jobTitles.first!
            return jobTitles[row]
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch style {
        case .address:
            self.selectedTitle = address[row]
        case .gender:
            self.selectedTitle = genderTitles[row]
        case .marriage:
            self.selectedTitle = marriageTitles[row]
        case .job:
            self.selectedTitle = jobTitles[row]
        default:
            self.selectedTitle = ""
        }
    }
    
}
