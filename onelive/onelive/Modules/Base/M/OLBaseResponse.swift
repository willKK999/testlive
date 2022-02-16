

import UIKit
import HandyJSON

public enum HttpResponseCode : Int {
    case success = 200
    case created = 210
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case busy = 999
    case failure = 11111 //自定义
}

class OLBaseResponse<T: Any>: OLBaseModel {
    /// 服务端返回码
    var code: Int?
    /// 服务端返回信息
    var msg: String?
    /// 时间戳
    var timestamp: Int?
    // 具体的data的格式和业务相关，故用泛型定义
    var data: T?
    
    var isSuccess: Bool {
        get {
            return code == HttpResponseCode.success.rawValue
        }
        set {
            
        }
    }
    
//    init(code: Int?, msg: String?) {
//        super.init()
//        self.code = code
//        self.msg = msg
//    }
    
}
