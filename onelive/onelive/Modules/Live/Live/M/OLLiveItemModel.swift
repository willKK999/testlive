

import UIKit
import HandyJSON

class OLLiveItemModel: NSObject,HandyJSON {
    ///主播id
    @objc var anchorId = 0
    ///用户ID
    @objc var userId = 0
    ///直播间ID
    @objc var studioId = 0
    ///直播间num
    @objc var studioNum: String?
    ///直播间标题
    @objc var studioTitle: String?
    ///直播间背景图
    @objc var studioThumbImage: String?
    ///直播间封面图（大图）
    @objc var studioBackground: String?
    ///国家名
    @objc var countryName: String?
    ///在线登录观看人数
    @objc var viewsNumber = 0
    
    public required override init() {}
}

