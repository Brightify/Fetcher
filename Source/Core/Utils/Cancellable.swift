//
//  Cancellable.swift
//  Fetcher
//
//  Created by Tadeas Kriz on 24/01/16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import Foundation

/// Can be used to cancel requests.
public final class Cancellable {
    public private(set) var isCancelled = false

    private let syncQueue = DispatchQueue(label: "Cancellable_syncQueue")
    
    private var cancelAction: () -> Void
    private var cancellables: [Cancellable] = []

    public init(cancelAction: @escaping () -> Void = {}) {
        self.cancelAction = cancelAction
    }
    
    public func cancel() {
        syncQueue.sync {
            cancelNotSynchronized()
        }
    }
    
    public func add(cancellable: Cancellable) {
        syncQueue.sync {
            cancellables.append(cancellable)
            if (isCancelled) {
                cancelNotSynchronized()
            }
        }
    }
    
    private func cancelNotSynchronized() {
        isCancelled = true
        cancelAction()
        cancellables.forEach { $0.cancelNotSynchronized() }
    }
}
