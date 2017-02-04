//
//  Methods.swift
//  Fetcher
//
//  Created by Filip Dolnik on 05.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

open class CONNECT<IN, OUT>: Endpoint<IN, OUT> {
    
    open override static var method: HTTPMethod {
        return .connect
    }
}

open class DELETE<IN, OUT>: Endpoint<IN, OUT> {
    
    open override static var method: HTTPMethod {
        return .delete
    }
}

open class GET<IN, OUT>: Endpoint<IN, OUT> {
    
    open override static var method: HTTPMethod {
        return .get
    }
}

open class HEAD<IN, OUT>: Endpoint<IN, OUT> {
    
    open override static var method: HTTPMethod {
        return .head
    }
}

open class OPTIONS<IN, OUT>: Endpoint<IN, OUT> {
    
    open override static var method: HTTPMethod {
        return .options
    }
}

open class PATCH<IN, OUT>: Endpoint<IN, OUT> {
    
    open override static var method: HTTPMethod {
        return .patch
    }
}

open class POST<IN, OUT>: Endpoint<IN, OUT> {
    
    open override static var method: HTTPMethod {
        return .post
    }
}

open class PUT<IN, OUT>: Endpoint<IN, OUT> {
    
    open override static var method: HTTPMethod {
        return .put
    }
}

open class TRACE<IN, OUT>: Endpoint<IN, OUT> {
    
    open override static var method: HTTPMethod {
        return .trace
    }
}
