
import Foundation

class OLAreaCodeListModel: OLBaseModel {
    var list: [AreaCodeModel]!
}

class AreaCodeModel: OLBaseModel {
    //主键ID
    var id: Int!
    //国家简称
    var country: String!
    //英文名
    var name: String!
    //中文名
    var op_name: String!
    //区号
    var area_code: String!
    
    var areaCodeString: String {
        get {
           return "+" + area_code + " "  + (isLanguageEnglish() ? name : op_name)
        }
        set {
            
        }
    }
}

extension AreaCodeModel {
    /// 获取系统语言方法
    private func getCurrentLanguage() -> String {
        let userLanguage:Array   = UserDefaults.standard.object(forKey: "AppleLanguages") as! Array<Any>
        let preferredLang = userLanguage.first as! String
        switch preferredLang {
        case "en-US", "en-CN":
            return "en"//英文
        case "zh-Hans-US","zh-Hans-CN","zh-Hant-CN","zh-TW","zh-HK","zh-Hans":
            return "cn"//中文
        default:
            return "en"
        }
    }
    private func isLanguageEnglish() -> Bool {
        return getCurrentLanguage() == "en" ? true : false
    }
}

