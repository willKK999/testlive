

import Foundation
import HandyJSON

fileprivate let oUserToken: String = "UserToken"

class OLLoginManager {
    static let shared = { OLLoginManager() }()
    //登录token
    var tokenModel: OLLoginTokenModel?
    //UserDefaults
    let defaults = UserDefaults.standard
    
    init() {
        let tokenModel: OLLoginTokenModel? = {
            if let json = defaults.dictionary(forKey: oUserToken) {
                if let model = OLLoginTokenModel.deserialize(from: json, designatedPath: nil) {
                    return model
                }
            }
            return nil
        }()
        self.tokenModel = tokenModel
    }
    
    func setLoginTokenModel(_ model: OLLoginTokenModel) {
        tokenModel = model
        
        defaults.set(model.toJSON(), forKey: oUserToken)
    }
    
    /// 判断是否登录
    func isLogin() -> Bool {
        if tokenModel != nil{
            return true
        } else {
            return false
        }
    }
    
    func safeToken() -> String {
        if tokenModel != nil {
            return tokenModel!.acctoken ?? ""
        } else {
            return ""
        }
    }
    
    /// 退出时清除变量
    func logout() {
        self.tokenModel = nil
        
        defaults.set(nil, forKey: oUserToken)
        
    }
}


class OLLoginTokenModel: OLBaseModel {
    ///登录token
    var acctoken: String?
    ///注册时候的国家code值
    var registerCountryCode: String?
}
