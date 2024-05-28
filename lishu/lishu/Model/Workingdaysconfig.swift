//
//  Workingdaysconfig.swift
//  lishu
//
//  Created by xueping wang on 2024/5/18.
//


struct Workingdaysconfig: Decodable {

    let configId: String
    let code: String
    let configurations: String
    let default_configuration: String?
    let flag: String?
    let website: String?
}
