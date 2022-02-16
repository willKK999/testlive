

import UIKit

class OLUserModel: OLBaseModel {
    ///会员ID
    var userId: Int?
    ///会员头像
    var avatar: String?
    ///用户位置
    var area: String?
    ///用户昵称
    var nickName: String?
    ///性别 0保密 1男 2女
    var sex: Int?
    ///等级
    var level: Int?
    ///等级图标
    var levelIcon: String?
    ///等级昵称
    var levelName: String?
    ///当前用户是否已关注用户 false否true是
    var isFocus: Bool! = false
    ///是否游客
    var isTourists: Bool?
    ///用户备注内容
    var remark: String?
    ///粉丝数
    var fansNum: Int?
    ///关注数
    var focusNum: Int?
    ///送出的火力,计算方式：在直播间送出的礼物总金币数 * 100
    var firepower: String?
    
}

class OLLiveContributeModel: OLUserModel {
    ///排名
    var rankNo: Int?
}

class OLLiveGuardModel: OLUserModel {
    ///排名
    var rankNo: Int?
}


