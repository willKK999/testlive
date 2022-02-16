

import Foundation


class AESCryptManager {
    static let shared = { AESCryptManager() }()
    private lazy var key: String = { OLPixelManager.shared().getKeys() }()
    
    ///加密
    func aesEncryptString(with content:String) -> String {
        AESCrypt.aesEncryptString(withContent: content, key: key)
    }
    func aesEncryptString(with content:String, key: String) -> String {
        AESCrypt.aesEncryptString(withContent: content, key: key)
    }
    ///解密
    func aesDecryptString(with content:String) -> String {
        AESCrypt.aesDecryptString(withContent: content, key: key)
    }
    func aesDecryptString(with content:String, key: String) -> String? {
       let decryptString = AESCrypt.aesDecryptString(withContent: content, key: key)
       if  decryptString != "" {
            return decryptString
        }
        return content
    }
    
}

