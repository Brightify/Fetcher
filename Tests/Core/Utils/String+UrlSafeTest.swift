//
//  String+UrlSafeTest.swift
//  Fetcher
//
//  Created by Filip Dolnik on 27.01.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import Fetcher

class String_UrlSafeTest {
    
    func apiTest() {
        _ = "".urlFragmentSafe
        _ = "".urlHostSafe
        _ = "".urlPasswordSafe
        _ = "".urlPathSafe
        _ = "".urlQuerySafe
        _ = "".urlUserSafe
    }
}
