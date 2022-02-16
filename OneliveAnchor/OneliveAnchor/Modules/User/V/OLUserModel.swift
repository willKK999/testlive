

import UIKit

class OLUserModel: OLBaseModel {
    /**
     "focusNum" : 1,
     "id" : 54,
     "fansNum" : 0,
     "sex" : 0,
     "userType" : 1,
     "accno" : "XR4CY1sgQ0",
     "maritalStatus" : 0,
     "avatar" : "https:\/\/onelive.s3.ap-northeast-2.amazonaws.com\/oneLive_image\/headImg3-3.png",
     "nickNameStatus" : true,
     "userLevel" : 0,
     "nickName" : "User319T2UT",
     "personalSignature" : "用户签名测试"*/
    ///会员ID
    var id: Int?
    ///会员ID
    var userId: Int?
    ///会员类型
    var userType: Int?
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
    var userLevel: Int?
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
    
    var accno: String?
    var maritalStatus: Int?
    var nickNameStatus: Bool?
    var personalSignature: String?
}

class OLLiveContributeModel: OLUserModel {
    ///排名
    var rankNo: Int?
}

class OLLiveGuardModel: OLUserModel {
    ///排名
    var rankNo: Int?
}


