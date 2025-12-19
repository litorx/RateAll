//
//  CacheManager.swift
//  RateAll
//
//  Created by Vitor de Souza Nascimento on 19/12/25.
//

import Foundation

final class CacheManager<T> {
    private var cache: [String: CacheEntry<T>] = [:]
    private let queue = DispatchQueue(label: "com.rateall.cache", attributes: .concurrent)
    
    struct CacheEntry<T> {
        let value: T
        let timestamp: Date
    }
    
    func set(key: String, value: T) {
        queue.async(flags: .barrier) {
            self.cache[key] = CacheEntry(value: value, timestamp: Date())
        }
    }
    
    func get(key: String, maxAge: TimeInterval) -> T? {
        queue.sync {
            guard let entry = cache[key] else { return nil }
            
            let age = Date().timeIntervalSince(entry.timestamp)
            guard age < maxAge else {
                cache.removeValue(forKey: key)
                return nil
            }
            
            return entry.value
        }
    }
    
    func clear() {
        queue.async(flags: .barrier) {
            self.cache.removeAll()
        }
    }
    
    func remove(key: String) {
        queue.async(flags: .barrier) {
            self.cache.removeValue(forKey: key)
        }
    }
}
