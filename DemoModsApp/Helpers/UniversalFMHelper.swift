//
//  UniversalFMHelper.swift
//  DemoModsApp
//
//  Created by TD on 25.05.2024.
//

import Foundation

class UniversalFMHelper {
    
    static let shared = UniversalFMHelper()
    
    private let fileManager = FileManager.default
    private let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
      
    func save<T: Codable>(_ data: T, to fileName: String) {
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        do {
            let encodedData = try JSONEncoder().encode(data)
            try encodedData.write(to: fileURL)
            print("Saved \(T.self) to file: \(fileName)")
        } catch {
            print("Error encoding \(T.self): \(error)")
        }
    }
    
    func load<T: Codable>(from fileName: String) -> T? {
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard fileManager.fileExists(atPath: fileURL.path) else {
            print("File not found: \(fileName)")
            return nil
        }
        do {
            let data = try Data(contentsOf: fileURL)
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            print("Loaded \(T.self) from file: \(fileName)")
            return decodedData
        } catch {
            print("Error decoding \(T.self): \(error)")
            return nil
        }
    }
    
    func clearAllCache(keys: [String]) {
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil, options: [])
            for fileURL in fileURLs {
                if !keys.contains(fileURL.lastPathComponent) && fileURL.pathExtension.lowercased() != "json" {
                    try fileManager.removeItem(at: fileURL)
                    print("Clearing file: \(fileURL.lastPathComponent)")
                }
            }
        } catch {
            print("Error clearing image cache:", error)
        }
    }
}
