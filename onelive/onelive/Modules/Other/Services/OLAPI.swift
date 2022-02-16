

import Foundation
import UIKit
import DeviceKit

public struct OLAPI {
    static let api_debug = false
    /// 项目的域名
    static var DOMAIN = api_debug ? "http://9003-180-191-174-207.ngrok.io/" : "http://54.180.119.120:4040/"
//    static var DOMAIN_DEBUG = "http://b540-45-112-46-93.ngrok.io/"
    
    // MARK: 首页 直播
    public struct Index {
        ///POST /index/app/v1/getColumn查询首页栏目表信息
        public static let getColumn = OLAPIItem("/index/app/v1/getColumn", d: "首页栏目表信息", m: .post)
        ///POST /index/app/v1/getLiveAdvList 获取推荐栏广告位
        public static let getLiveAdvList = OLAPIItem("/index/app/v1/getLiveAdvList", d: "获取推荐栏广告位", m: .post)
        ///POST /index/app/v1/getRecommend推荐区的四个推荐直播
        public static let getRecommend = OLAPIItem("/index/app/v1/getRecommend", d: "推荐区的四个推荐直播", m: .post)
        ///POST /index/app/v1/getHot正在热播
        public static let getHot = OLAPIItem("/index/app/v1/getHot", d: "正在热播", m: .post)
        ///POST /index/app/v1/getLiveBannerList获取直播首页轮播广告
        public static let getLiveBannerList = OLAPIItem("/index/app/v1/getLiveBannerList", d: "获取直播首页轮播广告", m: .post)
        ///POST /index/app/v1/getRecommendByHeat 推荐主播:根据主播热度
        public static let getRecommendByHeat = OLAPIItem("/index/app/v1/getRecommendByHeat", d: "推荐主播:根据主播热度", m: .post)
        ///POST /index/app/v1/getLiveFocusList获取关注的直播房间列表
        public static let getLiveFocusList = OLAPIItem("/index/app/v1/getLiveFocusList", d: "获取关注的直播房间列表", m: .post)
        ///POST /index/app/v1/getLiveHotList获取热门的直播房间列表
        public static let getLiveHotList = OLAPIItem("/index/app/v1/getLiveHotList", d: "获取热门的直播房间列表", m: .post)
        ///POST /index/app/v1/getLiveNearbyList获取附近的直播房间列表
        public static let getLiveNearbyList = OLAPIItem("/index/app/v1/getLiveNearbyList", d: "获取附近的直播房间列表", m: .post)
        ///POST /index/app/v1/getLivePopList获取推广的直播房间列表
        public static let getLivePopList = OLAPIItem("/index/app/v1/getLivePopList", d: "获取推广的直播房间列表", m: .post)
        ///POST /index/app/v1/search搜索
        public static let search = OLAPIItem("/index/app/v1/search", d: "搜索", m: .post)
    }
    
    public struct AdvNotic {
        ///POST /advNotice/app/v1/recommend直播列表推荐栏目公告，一条数据
        public static let recommend = OLAPIItem("/advNotice/app/v1/recommend", d: "直播列表推荐栏目公告", m: .post)
    }
    
    // MARK: 直播相关接口
    public struct Live {
        ///POST /live/app/v1/getRoomDetail通过房间号获取直播间详情
        public static let getRoomDetail = OLAPIItem("/live/app/v1/getRoomDetail", d: "直播间详情", m: .post)
        ///POST /live/app/v1/getLiveTabItemList获取tab栏配置信息
        public static let getLiveTabItemList = OLAPIItem("/live/app/v1/getLiveTabItemList", d: "tab栏配置信息", m: .post)
        ///POST /live/app/v1/begin 主播开播
        public static let begin = OLAPIItem("/live/app/v1/begin", d: "主播开播", m: .post)
        ///POST /live/app/v1/getLiveRecommendList通过房间号获取推荐的直播房间列表
        public static let getLiveRecommendList = OLAPIItem("/live/app/v1/getLiveRecommendList", d: "推荐的直播房间列表", m: .post)
        ///POST /live/app/v1/getContributeList通过房间号获取贡献榜列表
        public static let getContributeList = OLAPIItem("/live/app/v1/getContributeList", d: "贡献榜列表", m: .post)
        ///POST /live/app/v1/getLiveGuardList通过房间号获取守护榜列表
        public static let getLiveGuardList = OLAPIItem("/live/app/v1/getLiveGuardList", d: "守护榜列表", m: .post)
        ///POST /live/app/v1/getRoomActList返回直播间活动信息列表
        public static let getRoomActList = OLAPIItem("/live/app/v1/getRoomActList", d: "直播间活动信息列表", m: .post)
    }
    
    // MARK: 主播
    public struct Anchor {
        ///POST /anchor/app/v1/getAnchorInfo获取直播间头部主播信息
        public static let getAnchorInfo = OLAPIItem("/anchor/app/v1/getAnchorInfo", d: "直播间头部主播信息", m: .post)
        ///POST /anchor/app/v1/getAnchorDetailInfo获取直播间主播名片
        public static let getAnchorDetailInfo = OLAPIItem("/anchor/app/v1/getAnchorDetailInfo", d: "直播间主播名片", m: .post)
    }
    
    // MARK: 直播房间内相关接口
    public struct Room {
        ///POST /room/app/v1/checKicking校验当前用户是否可以进入房间， true: 可以进入
        public static let checKicking = OLAPIItem("/room/app/v1/checKicking", d: "校验当前用户是否可以进入房间", m: .post)
        ///POST /room/app/v1/onlineUsersCount查询直播间在线观众数量
        public static let onlineUsersCount = OLAPIItem("/room/app/v1/onlineUsersCount", d: "直播间在线观众数量", m: .post)
        ///POST /room/app/v1/onlineUsers查询直播间在线观众50个
        public static let onlineUsers = OLAPIItem("/room/app/v1/onlineUsers", d: "直播间在线观众", m: .post)
        ///POST /room/app/v1/checkBanned校验当前用户是否可以发言， true: 可以发言
        public static let checkBanned = OLAPIItem("/room/app/v1/checkBanned", d: "校验当前用户是否可以发言", m: .post)
        ///POST /room/app/v1/sendBarrage用户发送弹幕接口
        public static let sendBarrage = OLAPIItem("/room/app/v1/sendBarrage", d: "用户发送弹幕", m: .post)
        ///POST /room/app/v1/fastWords根据请求头lang 返回聊天快捷语
        public static let fastWords = OLAPIItem("/room/app/v1/fastWords", d: "聊天快捷语", m: .post)
        ///POST /room/app/v1/checkGift礼物校验接口：当前礼物是否可赠送，不可赠送需刷新礼物列表
        public static let checkGift = OLAPIItem("/room/app/v1/checkGift", d: "当前礼物是否可赠送", m: .post)
        ///POST /room/app/v1/giftGiving礼物打赏接口
        public static let giftGiving = OLAPIItem("/room/app/v1/giftGiving", d: "礼物打赏接口", m: .post)
        ///POST /room/app/v1/giftList直播礼物列表
        public static let giftList = OLAPIItem("/room/app/v1/giftList", d: "直播礼物列表", m: .post)
    }
    
    //MARK: Login 登录 注册
    public struct Login {
        ///POST /login/app/v1/visitorLogin游客注册登录
        public static let visitorLogin = OLAPIItem("/login/app/v1/visitorLogin", d: "游客注册登录", m: .post)
    }
    
    // MARK: 用户
    public struct User {
        ///POST /user/app/v1/getUserDetailInfo获取直播间用户名片
        public static let getUserDetailInfo = OLAPIItem("/user/app/v1/getUserDetailInfo", d: "直播间用户名片", m: .post)
        ///POST /user/app/v1/focusUser关注用户
        public static let focusUser = OLAPIItem("/user/app/v1/focusUser", d: "关注用户", m: .post)
        ///POST /user/app/v1/cancleUser取消关注用户
        public static let cancleUser = OLAPIItem("/user/app/v1/cancleUser", d: "取消关注用户", m: .post)
    }
    
    // MARK: 彩票 游戏
    public struct Lottery {
        ///POST /lottery/app/v1/getGameCodeList直播间-游戏code值列表
        public static let getGameCodeList = OLAPIItem("/lottery/app/v1/getGameCodeList", d: "直播间-游戏code值列表", m: .post)
        ///POST /lottery/app/v1/getLiveGameList直播间-直播间游戏列表
        public static let getLiveGameList = OLAPIItem("/lottery/app/v1/getLiveGameList", d: "直播间-直播间游戏列表", m: .post)
    }

}

/// 分页信息
public struct OLAPIPage {
    /// 分页页码
    enum Key: String {
        case pageNum     = "pageNum"
        case pageSize   = "pageSize"
    }
    
    /// 分页默认值
    enum DefValue: Int {
        case pageNum     = 1   //默认从1开始
        case pageSize   = 20  //默认30
    }
}

/**
 c1kgVioySoUVimtw
 f2kgVioykoURWmtg
 e3kgGioydoURWmtf
 b9rtFfoydoURnjtp
 t6rtTfmcdoURnjth
 */
public enum AppleType: Int {
    case key1 = 1, key2, key3, key4, key5
    var keys: String {
        switch self {
        case .key1:
            return "c1kgVioySoUVimtw"
        case .key2:
            return "f2kgVioykoURWmtg"
        case .key3:
            return "e3kgGioydoURWmtf"
        case .key4:
            return "b9rtFfoydoURnjtp"
        case .key5:
            return "t6rtTfmcdoURnjth"
        }
    }
}

/// Type representing HTTP methods.
public enum HttpRequestType {
    /// Common HTTP methods.
    case get, post, put, delete, patch
}

public let appleType = AppleType.key1

public struct OLAPIItem {
    public var url: String { OLAPI.DOMAIN + URLPath }  //域名 + path
    public let description: String
    public let extra: String?
    public var method: HttpRequestType
    public var generalHeaders: [String: String]? //header通用参数
    private let URLPath: String  // URL的path
    
    
    init(_ path: String, d: String, e: String? = nil, m: HttpRequestType = .get) {
        URLPath = "api" +  path
        description = d
        extra = e
        method = m
        generalHeaders = ["Content-Type": "application/json",
                          "lang": "zh_CN",
                          "onelive-source": "ios",
                          "onelive-devices": Device.current.description,
                          "onelive-devicesId": getDeviceId()!,
                          "onelive-appleType": String(appleType.rawValue)
                          ]
        
        let timestamp = getTimestamp()
        generalHeaders!["onelive-timestamp"] = timestamp
        let random = getRandom()
        generalHeaders!["onelive-random"] = random
        //Authorization  用户token
        let Authorization = OLLoginManager.shared.safeToken()
        generalHeaders!["Authorization"] = Authorization
        let url = getlastPathComponent()
        generalHeaders!["onelive-url"] = url
        var content: String = ""
        content.append(contentsOf: timestamp)
        content.append(contentsOf: "||" + random)
        content.append(contentsOf: "||" + Authorization)
        content.append(contentsOf: "||" + url)
        let signature = getSignature(content: content)
        generalHeaders!["onelive-signature"] = signature
    }
    
    init(_ path: String, m: HttpRequestType) {
        self.init(path, d: "", e: nil, m: m)
    }
    
    
    func getDeviceId() -> String? {
        let currentDeviceUUID = UIDevice.current.identifierForVendor
        var currentDeviceUUIDStr = currentDeviceUUID?.uuidString
        currentDeviceUUIDStr = currentDeviceUUIDStr?.replacingOccurrences(of: "-", with: "")
        currentDeviceUUIDStr = currentDeviceUUIDStr?.lowercased()
        return currentDeviceUUIDStr
    }
    func getTimestamp() -> String {
        let timestamp = Int(Date().timeIntervalSince1970 * 1000.0)
        return String(timestamp)
    }
    func getRandom() -> String {
        let random = Int(arc4random() % 10000 + 1)
        return String(random)
    }
    func getlastPathComponent() -> String {
        let URL = URL(string: url)
        return URL!.lastPathComponent
    }
    func getSignature(content:String) -> String {
        return AESCryptManager.shared.aesEncryptString(with: content,key: appleType.keys)
    }
}
