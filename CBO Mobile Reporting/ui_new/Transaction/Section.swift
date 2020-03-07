//
//  Section.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 08/01/20.
//  Copyright © 2020 Javed Hussain. All rights reserved.
//

import Foundation

struct Section {
    var section: String!
    var rows: [String]!
    var itemId: String!
    var remark: [String]!
    var quan: [String]!
    var expanded: Bool!

    init(section: String!, rows: [String], quan: [String],remark: [String],itemId: String, expanded: Bool!) {
        self.section = section
        self.rows = rows
        self.quan = quan
        self.remark = remark
        self.itemId = itemId
        self.expanded = expanded
    }
}
