

import UIKit

class OLFastWordsModel: OLBaseModel {
    ///id
    var id: Int?
    ///快捷回复语句
    var context: String?
    ///语言标识
    var lang: String?
    ///是否展示，默认是
    var isShow: Bool! = true
    ///第几页
    var pageNum: Int?
    ///每页最大页数
    var pageSize: Int?
}
