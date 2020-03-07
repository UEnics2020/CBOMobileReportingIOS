//
//  Response.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 16/05/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import UIKit

public protocol Response {
    func onSuccess( message : [String : AnyObject]);
    func onError( title : String, description : String);
}
