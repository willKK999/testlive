

import Foundation

extension NSMutableAttributedString {

    convenience init?(elements: [(str :String, attr : [NSAttributedString.Key:Any])]) {
        guard elements.count > 0 else {
            return nil
            
        }
        let allString:String = elements.reduce("") { (res, ele) ->String in
            return res + ele.str
            
        }
        self.init(string: allString)
        for ele in elements {
            let eleStr = ele.str
            let range: Range = allString.range(of: eleStr)!
            let nsRange: NSRange = NSRange(range, in: allString)
            self.addAttributes(ele.attr, range: nsRange)
            
        }
        
    }

}
