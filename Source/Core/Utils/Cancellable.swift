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
    
    private static let syncQueue = DispatchQueue(label: "Cancellable_syncQueue")
    
    private var cancelAction: () -> Void
    private var cancellables: [Cancellable] = []
    private var shouldCancel = false
    
    public init(cancelAction: @escaping () -> Void = {}) {
        self.cancelAction = cancelAction
    }
    
    public func cancel() {
        Cancellable.syncQueue.sync {
            cancelNotSynchronized()
        }
    }
    
    public func add(cancellable: Cancellable) {
        Cancellable.syncQueue.sync {
            cancellables.append(cancellable)
            if (shouldCancel) {
                cancelNotSynchronized()
            }
        }
    }
    
    private func cancelNotSynchronized() {
        shouldCancel = true
        cancelAction()
        cancellables.forEach { $0.cancelNotSynchronized() }
    }
}
