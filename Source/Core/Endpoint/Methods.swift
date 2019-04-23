//
//  Methods.swift
//  Fetcher
//
//  Created by Filip Dolnik on 05.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

public class CONNECT<IN, OUT>: Endpoint<IN, OUT> {
    
    public override static var method: HTTPMethod {
        return .connect
    }
}

public class DELETE<IN, OUT>: Endpoint<IN, OUT> {
    
    public override static var method: HTTPMethod {
        return .delete
    }
}

public class GET<IN, OUT>: Endpoint<IN, OUT> {
    
    public override static var method: HTTPMethod {
        return .get
    }
}

public class HEAD<IN, OUT>: Endpoint<IN, OUT> {
    
    public override static var method: HTTPMethod {
        return .head
    }
}

public class OPTIONS<IN, OUT>: Endpoint<IN, OUT> {
    
    public override static var method: HTTPMethod {
        return .options
    }
}

public class PATCH<IN, OUT>: Endpoint<IN, OUT> {
    
    public override static var method: HTTPMethod {
        return .patch
    }
}

public class POST<IN, OUT>: Endpoint<IN, OUT> {
    
    public override static var method: HTTPMethod {
        return .post
    }
}

public class PUT<IN, OUT>: Endpoint<IN, OUT> {
    
    public override static var method: HTTPMethod {
        return .put
    }
}

public class TRACE<IN, OUT>: Endpoint<IN, OUT> {
    
    public override static var method: HTTPMethod {
        return .trace
    }
}
