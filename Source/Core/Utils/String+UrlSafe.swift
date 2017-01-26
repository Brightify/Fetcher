//
//  String+UrlSafe.swift
//  Fetcher
//
//  Created by Tadeáš Kříž on 6/6/15.
//  Copyright © 2015 Brightify. All rights reserved.
//

import Foundation

extension String {
 
    /// Contains String with valid characters for URL fragment
    public var urlFragmentSafe: String {
        return addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? self
    }
    
    /// Contains String with valid characters for URL host
    public var urlHostSafe: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
    
    /// Contains String with valid characters for URL password
    public var urlPasswordSafe: String {
        return addingPercentEncoding(withAllowedCharacters: .urlPasswordAllowed) ?? self
    }
    
    /// Contains String with valid characters for URL path
    public var urlPathSafe: String {
        return addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? self
    }
    
    /// Contains String with valid characters for URL query
    public var urlQuerySafe: String {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
    }
    
    /// Contains String with valid characters for URL user
    public var urlUserSafe: String {
        return addingPercentEncoding(withAllowedCharacters: .urlUserAllowed) ?? self
    }
}