
import UIKit

class OLLotteryGameCodeModel: OLBaseModel {
    ///游戏分类名称
    var name: String!
    ///游戏分类code
    var code: String!
}

class OLLotteryGameModel: OLBaseModel {
    ///私彩分类ID
    var cateId: Int!
    ///游戏分类code
    var code: String!
    ///游戏名称
    var name: String!
    ///游戏编号（私彩编号）
    var gameNo: String!
    ///游戏类型,如棋牌chess、捕鱼fishing、电子electronic、视讯video、彩票lottery
    var gameType: String!
    ///游戏图标
    var iconUrl: String!
    ///是否进行跳转
    var isCanJump: String!
    ///是否是第三方游戏
    var isThird : String!
    ///跳转地址
    var jumpUrl: String!
    
}
