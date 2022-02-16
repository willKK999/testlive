

import UIKit

class OLActListModel: OLBaseModel {
    var gameList: [OLActivitiesModel]!
    var liveList: [OLActivitiesModel]!
}

class OLActivitiesModel: OLBaseModel {
    var id: Int!
    var link: String!
    var imgUrl: String!
}
