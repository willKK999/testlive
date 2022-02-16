

import UIKit

class OLLiveTabItemModel: OLBaseModel {
    ///id
    var id: Int?
    ///名称
    var name: String!
    ///唯一标识: live直播 game游戏 recharge充值 my我的 ,
    var iconCode: String!
    ///选中的图标
    var iconSelectedUrl: String!
    ///未选中的图标
    var iconUnselectedUrl: String!
}
