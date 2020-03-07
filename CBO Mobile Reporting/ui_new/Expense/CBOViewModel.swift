//
//  CBOViewModel.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 30/11/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import Foundation
public protocol CBOViewModel : class {
     associatedtype T
    var count: Int { get set }
    var view: T? { get set }
    func onUpdateView( context : UIViewController, view : T);
}

extension CBOViewModel {
   
    public func setView(context : UIViewController, view : T){
        self.view = view;
        if (view != nil){
            onUpdateView(context: context,view: view);
        }
    }
    


    public func isLoaded() -> Bool{
        count += 1;
        return count > 1;
    }
    public func getCount() -> Int{
        count += 1;
        return count;
    }

}
