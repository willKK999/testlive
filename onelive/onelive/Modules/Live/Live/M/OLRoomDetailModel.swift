

import UIKit

class OLRoomDetailModel: OLBaseModel {
    ///房间号码
    var studioNum: String?
    ///直播间名称
    var studioName: String?
    ///直播间状态 0：未开播，1：开播，2：网络状态不好
    var studioStatus: Int?
    ///直播间ID
    var studioId: Int?
    ///直播拉流地址
    var studioLivePath: String?
    ///试看时长:超过时间后要付费
    var trySeeTime: Int?
    ///按时收费:每N分钟收费金额,按场收费:一场的收费金额
    var chargeMoney = 0.0
    ///收费类型:0:免费 1:按时收费 2:按场收费
    var chargeType = 0
    
    ///主播会员ID
    var userId: Int?
    ///主播id
    var anchorId = 0
    ///火力值,计算方式：主播在直播间收到的总金币数 * 100
    var firepower: String?
    ///守护人数
    var guardNum : String?
    ///直播间主播简单信息
    var liveAnchorVO: OLAnchorModel?
    ///直播间在线人数列表，默认值显示前50条
    var onlineList: [OLOnlineModel]?
    ///在线人数
    var onlineNum: String?
   
    ///彩票/游戏id
    var gameId: Int?
    ///彩票/游戏图案地址
    var gameIcon: String?
    ///彩票/游戏名称
    var gameName: String?
    ///彩票/游戏开奖封盘时间（秒）
    var endTime: Int?
    ///主播开播时候，是否选择了游戏,false否true是
    var isSelectGame: Bool?
}

class OLOnlineModel: OLUserModel {
    
}

