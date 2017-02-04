//
//  String+UrlSafe.swift
//  Fetcher
//
//  Created by Tadeáš Kříž on 6/6/15.
//  Copyright © 2015 Brightify. All rights reserved.
//

import Foundation

extension String {
 
    public var urlFragmentSafe: String {
        return addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? self
    }
    
    public var urlHostSafe: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
    
    public var urlPasswordSafe: String {
        return addingPercentEncoding(withAllowedCharacters: .urlPasswordAllowed) ?? self
    }
    
    public var urlPathSafe: String {
        return addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? self
    }
    
    public var urlQuerySafe: String {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
    }
    
    public var urlUserSafe: String {
        return addingPercentEncoding(withAllowedCharacters: .urlUserAllowed) ?? self
    }
}
