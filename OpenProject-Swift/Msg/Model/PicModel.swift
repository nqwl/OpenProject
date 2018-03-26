//
//  PicModel.swift
//  OpenProject-Swift
//
//  Created by 亲点 on 2018/3/19.
//  Copyright © 2018年 陈辉. All rights reserved.
//

import UIKit
import ObjectMapper


struct PicModel: Mappable {

    init?(map: Map) {

    }
    mutating func mapping(map: Map) {
        dataId <- map["dataId"]
        small_url <- map["small_url"]
        small_width <- map["small_width"]
        small_height <- map["small_height"]
        mid_url <- map["mid_url"]
        mid_width <- map["mid_width"]
        mid_height <- map["mid_height"]
        image_url <- map["image_url"]
        image_width <- map["image_width"]
        image_height <- map["image_height"]
        fromurl <- map["fromurl"]
        obj_url <- map["obj_url"]
        title <- map["title"]
        albnumber <- map["albnumber"]
        set_id <- map["set_id"]
        content_sigh <- map["content_sigh"]
    }
    var dataId = "209976832"
    var small_url = ""
    var small_width = 230
    var small_height = 281
    var mid_url = ""
    var mid_width = 310
    var mid_height = 379
    var image_url = ""
    var image_width = 379
    var image_height = 734
    var fromurl = ""
    var obj_url = ""
    var title = ""
    var albnumber = 8
    var set_id = 92980
    var content_sigh = ""
}
