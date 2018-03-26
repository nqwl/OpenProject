//
//  MsgPicModel.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/3/19.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import Foundation
import ObjectMapper

struct MsgPicModel: Mappable {
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        tag1 <- map["tag1"]
        tag2 <- map["tag2"]
        tag3 <- map["tag3"]
        startIndex <- map["startIndex"]
        returnNumber <- map["returnNumber"]

        imgs <- map["imgs"]
        totalNum <- map["totalNum"]
        errno <- map["errno"]
        msg <- map["msg"]
    }

    var tag1 = ""
    var tag2 = ""
    var tag3 = ""
    var startIndex = "0"
    var returnNumber = 60

    var imgs = [PicModel]?.self
    var totalNum = 2528
    var errno = 0
    var msg = "success"
}
