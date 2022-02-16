

import Foundation


/// Dictionary -> String
public func oo_jsonDicToString(_ jsonDic: Dictionary<String, Any>,
                            encoding: String.Encoding = .utf8) -> String? {
    if (!JSONSerialization.isValidJSONObject(jsonDic)) {
        debugPrint("is not a valid json object")
        return nil
    }
    
    //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
    let data = try? JSONSerialization.data(withJSONObject: jsonDic, options: .prettyPrinted)
    let str = String(data:data!, encoding: String.Encoding.utf8)
   
    return str
}


/// String -> String
public func oo_stringToJsonString(jsonStr: String) -> String? {
    do {
        let data: Data = jsonStr.data(using: .utf8)!

        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
  
        let jsonString = oo_jsonDicToString((json as? Dictionary<String, Any>)!)
        return jsonString
    } catch _ {
        debugPrint("convert failed")
        
        return nil
    }
}


/// String -> Dictionary
public func oo_stringToJson(jsonStr: String) -> Dictionary<String, Any>? {
    do {
        let data: Data = jsonStr.data(using: .utf8)!

        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
  
        return json as? Dictionary<String, Any>
    } catch _ {
        debugPrint("convert failed")
        
        return nil
    }
}
