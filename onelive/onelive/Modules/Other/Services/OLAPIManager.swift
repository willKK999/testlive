

import Foundation
import Alamofire
import UIKit

class OLAPIManager {
    static let shared = { OLAPIManager() }()
    
    // MARK: 公共方法
    func request(
        _ api:  OLAPIItem,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        completion: @escaping (OLBaseResponse<Any>) -> Void) {
            guard let url = URL(string: api.url) else {
                oPrint("url出错")
                return
            }
            var request = URLRequest(url: url)
            var method = HTTPMethod.get
            switch api.method {
            case .get:
                method =  .get
            case .post:
                method = .post
            case .put:
                method = .put
            case .delete:
                method = .delete
            case .patch:
                method = .patch
            }
            request.httpMethod = method.rawValue
            //Headers
            var HTTPHeaders = api.generalHeaders!
            if let headers = api.generalHeaders {
                for (key,value) in headers.reversed() {
                    request.setValue(value, forHTTPHeaderField: key)
                }
            }
            if let headers = headers {
                for (key,value) in headers.reversed() {
                    request.setValue(value, forHTTPHeaderField: key)
                    HTTPHeaders[key] = value
                }
            }
            oPrint("【请求地址】: " + api.url)
            oPrint("【接口描述】:" + api.description)
            oPrint("【请求头部】:\n" + oo_jsonDicToString(HTTPHeaders)!)
            if let body = parameters {
                let jsonBody = oo_jsonDicToString(body)
                //加密
                let encryptJson = AESCryptManager.shared.aesEncryptString(with: jsonBody!,key: appleType.keys)
                request.httpBody = encryptJson.data(using: .utf8, allowLossyConversion: false)!
                oPrint("【请求参数】: \n" + jsonBody!)
                oPrint("【加密请求参数】: " + encryptJson)
            }
            AF.request(request).responseJSON {[weak self] (response) in
                guard let self = self else{ return }
                oPrint("【请求地址】: " + api.url)
                oPrint("【接口描述】: " + api.description)
                switch response.result {
                case .success:
                    guard let validData = response.data else {
                        oPrint("数据请求异常")
                        self.failure(error: "数据请求异常", completion: completion)
                        return
                    }
                    guard let json = String(data: validData, encoding: String.Encoding.utf8) else {
                        oPrint("数据转换json失败")
                        self.failure(error: "数据转换json失败", completion: completion)
                        return
                    }
                    
                    oPrint("【响应数据】: \n" + json)
                    guard let jsonDecrypt = AESCryptManager.shared.aesDecryptString(with: json,key: appleType.keys) else {
                        oPrint("json解密失败")
                        self.failure(error: "json解密失败", completion: completion)
                        return
                    }
                    oPrint("【解密JSON数据】:：\n" + oo_stringToJsonString(jsonStr:jsonDecrypt)!)
                    guard let model = OLBaseResponse<Any>.deserialize(from: jsonDecrypt) else {
                        oPrint("模型转换失败")
                        self.failure(error: "模型转换失败", completion: completion)
                        return
                    }
                    completion(model)
                case .failure:
                    oPrint("网络请求异常")
                    self.failure(error: "网络请求异常", completion: completion)
                    break
                }
            }
    }
    func failure(error:String, completion: @escaping (OLBaseResponse<Any>) -> Void) {
        let model = OLBaseResponse<Any>.deserialize(from: ["code": HttpResponseCode.failure.rawValue,
                                                           "msg": error])
        completion(model!)
    }
}


extension OLAPIManager {
    
    // MARK: 首页 Index
    func getColumnList(completion: @escaping (_ result: OLBaseResponse<Array<OLColumnModel>>) -> Void) {
        request(OLAPI.Index.getColumn, parameters: nil, headers: nil) { (result) in
           let model = OLBaseResponse<Array<OLColumnModel>>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
    
    func getLiveAdvList(completion: @escaping (_ result: OLBaseResponse<Array<OLAdvModel>>) -> Void) {
        request(OLAPI.Index.getLiveAdvList, parameters: nil, headers: nil) { (result) in
           let model = OLBaseResponse<Array<OLAdvModel>>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
    
    func getLiveBannerList(completion: @escaping (_ result: OLBaseResponse<Array<OLAdvModel>>) -> Void) {
        request(OLAPI.Index.getLiveBannerList, parameters: nil, headers: nil) { (result) in
           let model = OLBaseResponse<Array<OLAdvModel>>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
    
    func getRecommend(completion: @escaping (_ result: OLBaseResponse<OLLiveListModel>) -> Void) {
        request(OLAPI.Index.getRecommend, parameters: nil, headers: nil) { (result) in
           let model = OLBaseResponse<OLLiveListModel>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
    
    func getRecommendByHeat(_ pageNum: Int = OLAPIPage.DefValue.pageNum.rawValue, pageSize: Int = OLAPIPage.DefValue.pageSize.rawValue, completion: @escaping (_ result: OLBaseResponse<OLLiveListModel>) -> Void) {
        let parameters: [String: Any] = [
            OLAPIPage.Key.pageNum.rawValue: pageNum,
            OLAPIPage.Key.pageSize.rawValue: pageSize
        ]
        request(OLAPI.Index.getRecommendByHeat, parameters: parameters, headers: nil) { (result) in
           let model = OLBaseResponse<OLLiveListModel>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
    
    func getLiveFocusList(_ pageNum: Int = OLAPIPage.DefValue.pageNum.rawValue, pageSize: Int = OLAPIPage.DefValue.pageSize.rawValue, completion: @escaping (_ result: OLBaseResponse<OLLiveListModel>) -> Void) {
        let parameters: [String: Any] = [
            OLAPIPage.Key.pageNum.rawValue: pageNum,
            OLAPIPage.Key.pageSize.rawValue: pageSize
        ]
        //登录完成后user token
        let headers = [
            "Authorization":  OLLoginManager.shared.safeToken()
        ]
        request(OLAPI.Index.getLiveFocusList, parameters: parameters, headers: headers) { (result) in
           let model = OLBaseResponse<OLLiveListModel>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
    
    func getLiveHotList(_ pageNum: Int = OLAPIPage.DefValue.pageNum.rawValue, pageSize: Int = OLAPIPage.DefValue.pageSize.rawValue, completion: @escaping (_ result: OLBaseResponse<OLLiveListModel>) -> Void) {
        let parameters: [String: Any] = [
            OLAPIPage.Key.pageNum.rawValue: pageNum,
            OLAPIPage.Key.pageSize.rawValue: pageSize
        ]
        request(OLAPI.Index.getLiveHotList, parameters: parameters, headers: nil) { (result) in
           let model = OLBaseResponse<OLLiveListModel>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
    
    func getLiveNearbyList(_ pageNum: Int = OLAPIPage.DefValue.pageNum.rawValue, pageSize: Int = OLAPIPage.DefValue.pageSize.rawValue, completion: @escaping (_ result: OLBaseResponse<OLLiveListModel>) -> Void) {
        let parameters: [String: Any] = [
            OLAPIPage.Key.pageNum.rawValue: pageNum,
            OLAPIPage.Key.pageSize.rawValue: pageSize
        ]
        request(OLAPI.Index.getLiveNearbyList, parameters: parameters, headers: nil) { (result) in
           let model = OLBaseResponse<OLLiveListModel>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
    
    func getLivePopList(_ pageNum: Int = OLAPIPage.DefValue.pageNum.rawValue, pageSize: Int = OLAPIPage.DefValue.pageSize.rawValue, completion: @escaping (_ result: OLBaseResponse<OLLiveListModel>) -> Void) {
        let parameters: [String: Any] = [
            OLAPIPage.Key.pageNum.rawValue: pageNum,
            OLAPIPage.Key.pageSize.rawValue: pageSize
        ]
        request(OLAPI.Index.getLivePopList, parameters: parameters, headers: nil) { (result) in
           let model = OLBaseResponse<OLLiveListModel>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
    
    func getLiveSearchList(searchText: String, _ pageNum: Int = OLAPIPage.DefValue.pageNum.rawValue, pageSize: Int = OLAPIPage.DefValue.pageSize.rawValue, completion: @escaping (_ result: OLBaseResponse<OLLiveListModel>) -> Void) {
        let parameters: [String: Any] = [
            "searchText":searchText,
            OLAPIPage.Key.pageNum.rawValue: pageNum,
            OLAPIPage.Key.pageSize.rawValue: pageSize
        ]
        request(OLAPI.Index.search, parameters: parameters, headers: nil) { (result) in
           let model = OLBaseResponse<OLLiveListModel>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
    //MARK: 公告
    ///POST /advNotice/app/v1/recommend直播列表推荐栏目公告，一条数据
    func recommendNotice(completion: @escaping (_ result: OLBaseResponse<OLAdvNoticeModel>) -> Void) {
        request(OLAPI.AdvNotic.recommend, parameters: nil, headers: nil) { (result) in
           let model = OLBaseResponse<OLAdvNoticeModel>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
    
    // MARK: Login 登录 注册
    ///POST /login/app/v1/visitorLogin游客注册登录
    func visitorLogin(completion: @escaping (_ result: OLBaseResponse<OLLoginTokenModel>) -> Void) {
        let headers: [String: String] = [
            "isTest": "1"
        ]
        request(OLAPI.Login.visitorLogin, parameters: nil, headers: headers) { (result) in
           let model = OLBaseResponse<OLLoginTokenModel>.deserialize(from: result.toJSON())
            //存储
            OLLoginManager.shared.setLoginTokenModel((model!.data)!)
            CommonManager.shared().token =  OLLoginManager.shared.safeToken();
//
            completion(model!)
        }
    }
    
    // MARK: Anchor 主播
    ///POST /anchor/app/v1/getAnchorInfo获取直播间头部主播信息
    func getAnchorInfo(anchorId: Int, completion: @escaping (_ result: OLBaseResponse<OLAnchorModel>) -> Void) {
        let parameters: [String: Any] = [
            "anchorId":anchorId,
        ]
        request(OLAPI.Anchor.getAnchorInfo, parameters: parameters, headers: nil) { (result) in
           let model = OLBaseResponse<OLAnchorModel>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
    ///POST /anchor/app/v1/getAnchorDetailInfo获取直播间主播名片
    func getAnchorDetailInfo(anchorId: Int, completion: @escaping (_ result: OLBaseResponse<OLAnchorModel>) -> Void) {
        let parameters: [String: Any] = [
            "anchorId":anchorId,
        ]
        request(OLAPI.Anchor.getAnchorDetailInfo, parameters: parameters, headers: nil) { (result) in
           let model = OLBaseResponse<OLAnchorModel>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
    
    // MARK: User 用户
    ///POST /user/app/v1/getUserDetailInfo获取直播间用户名片
    func getUserDetailInfo(userId: Int, completion: @escaping (_ result: OLBaseResponse<OLUserModel>) -> Void) {
        let parameters: [String: Any] = [
            "userId":userId,
        ]
        request(OLAPI.User.getUserDetailInfo, parameters: parameters, headers: nil) { (result) in
           let model = OLBaseResponse<OLUserModel>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
    ///用户关注&取消关注
    func followUser(isCancel: Bool, userId: Int, completion: @escaping (_ result: OLBaseResponse<String>) -> Void) {
        let parameters: [String: Any] = [
            "focusUserId":userId,
        ]
        //POST /user/app/v1/focusUser关注用户
        var apiItem = OLAPI.User.focusUser
        if isCancel {
            //POST /user/app/v1/cancleUser取消关注用户
            apiItem = OLAPI.User.cancleUser
        }
        request(apiItem, parameters: parameters, headers: nil) { (result) in
           let model = OLBaseResponse<String>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
    
    // MARK: Live
    func getLiveTabItemList(completion: @escaping (_ result: OLBaseResponse<Array<OLLiveTabItemModel>>) -> Void) {
        request(OLAPI.Live.getLiveTabItemList, parameters: nil, headers: nil) { (result) in
           let model = OLBaseResponse<Array<OLLiveTabItemModel>>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
    ///POST /live/app/v1/getRoomDetail通过房间号获取直播间详情
    func getRoomDetail(studioNum: String, completion: @escaping (_ result: OLBaseResponse<OLRoomDetailModel>) -> Void) {
        let parameters: [String: Any] = [
            "studioNum":studioNum,
        ]
        request(OLAPI.Live.getRoomDetail, parameters: parameters, headers: nil) { (result) in
           let model = OLBaseResponse<OLRoomDetailModel>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
    ///POST /live/app/v1/getLiveRecommendList通过房间号获取推荐的直播房间列表
    func getLiveRecommendList(studioNum: String,_ pageNum: Int = OLAPIPage.DefValue.pageNum.rawValue, pageSize: Int = OLAPIPage.DefValue.pageSize.rawValue, completion: @escaping (_ result: OLBaseResponse<OLLiveListModel>) -> Void) {
        let parameters: [String: Any] = [
            "studioNum":studioNum,
            OLAPIPage.Key.pageNum.rawValue: pageNum,
            OLAPIPage.Key.pageSize.rawValue: pageSize
        ]
        request(OLAPI.Live.getLiveRecommendList, parameters: parameters, headers: nil) { (result) in
           let model = OLBaseResponse<OLLiveListModel>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
    ///POST /live/app/v1/getContributeList通过房间号获取贡献榜列表
    func getContributeList(studioNum: String, completion: @escaping (_ result: OLBaseResponse<Array<OLLiveContributeModel>>) -> Void) {
        let parameters: [String: Any] = [
            "studioNum":studioNum,
            "type": 0,
        ]
        request(OLAPI.Live.getContributeList, parameters: parameters, headers: nil) { (result) in
           let model = OLBaseResponse<Array<OLLiveContributeModel>>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
    ///POST /live/app/v1/getLiveGuardList通过房间号获取守护榜列表
    func getLiveGuardList(studioNum: String, completion: @escaping (_ result: OLBaseResponse<Array<OLLiveGuardModel>>) -> Void) {
        let parameters: [String: Any] = [
            "studioNum":studioNum,
            "type": 0,
        ]
        request(OLAPI.Live.getLiveGuardList, parameters: parameters, headers: nil) { (result) in
           let model = OLBaseResponse<Array<OLLiveGuardModel>>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
    ///POST /live/app/v1/getRoomActList返回直播间活动信息列表
    func getRoomActList(completion: @escaping (_ result: OLBaseResponse<OLActListModel>) -> Void) {
        let parameters: [String: Any] = [
            "type": 1,
        ]
        request(OLAPI.Live.getRoomActList, parameters: parameters, headers: nil) { (result) in
           let model = OLBaseResponse<OLActListModel>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
    
    ///POST /room/app/v1/checKicking校验当前用户是否可以进入房间， true: 可以进入
    func checKicking(studioNum: String, completion: @escaping (_ result: OLBaseResponse<Bool>) -> Void) {
        let parameters: [String: Any] = [
            "studioNum":studioNum,
        ]
        request(OLAPI.Room.checKicking, parameters: parameters, headers: nil) { (result) in
           let model = OLBaseResponse<Bool>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
    
    ///POST /room/app/v1/checkBanned校验当前用户是否可以发言， true: 可以发言
    func checkBanned(studioNum: String, completion: @escaping (_ result: OLBaseResponse<Bool>) -> Void) {
        let parameters: [String: Any] = [
            "studioNum":studioNum,
        ]
        request(OLAPI.Room.checkBanned, parameters: parameters, headers: nil) { (result) in
           let model = OLBaseResponse<Bool>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
    
    ///POST /room/app/v1/fastWords根据请求头lang 返回聊天快捷语
    func fastWords(completion: @escaping (_ result: OLBaseResponse<Array<OLFastWordsModel>>) -> Void) {
        request(OLAPI.Room.fastWords, parameters: nil, headers: nil) { (result) in
           let model = OLBaseResponse<Array<OLFastWordsModel>>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
    
    ///POST /room/app/v1/onlineUsersCount查询直播间在线观众数量
    func onlineUsersCount(studioNum: String, completion: @escaping (_ result: OLBaseResponse<Int>) -> Void) {
        let parameters: [String: Any] = [
            "studioNum":studioNum,
        ]
        request(OLAPI.Room.onlineUsersCount, parameters: parameters, headers: nil) { (result) in
           let model = OLBaseResponse<Int>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
    
    ///POST /room/app/v1/onlineUsers查询直播间在线观众
    func onlineUsers(studioNum: String, completion: @escaping (_ result: OLBaseResponse<Array<OLOnlineModel>>) -> Void) {
        let parameters: [String: Any] = [
            "studioNum":studioNum,
        ]
        request(OLAPI.Room.onlineUsers, parameters: parameters, headers: nil) { (result) in
           let model = OLBaseResponse<Array<OLOnlineModel>>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
    
    // MARK: 直播间彩票 游戏
    ///POST /lottery/app/v1/getGameCodeList直播间-游戏code值列表
    func getGameCodeList(completion: @escaping (_ result: OLBaseResponse<Array<OLLotteryGameCodeModel>>) -> Void) {
        request(OLAPI.Lottery.getGameCodeList, parameters: nil, headers: nil) { (result) in
           let model = OLBaseResponse<Array<OLLotteryGameCodeModel>>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
    
    ///POST /lottery/app/v1/getLiveGameList直播间-直播间游戏列表
    func getLiveGameList(code: String, completion: @escaping (_ result: OLBaseResponse<Array<OLLotteryGameModel>>) -> Void) {
        let parameters: [String: Any] = [
            "code":code,
        ]
        request(OLAPI.Lottery.getLiveGameList, parameters: parameters, headers: nil) { (result) in
           let model = OLBaseResponse<Array<OLLotteryGameModel>>.deserialize(from: result.toJSON())
            completion(model!)
        }
    }
}
