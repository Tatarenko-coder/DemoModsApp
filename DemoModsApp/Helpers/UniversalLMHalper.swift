//
//  UniversalLMHalper.swift
//  DemoModsApp
//
//  Created by TD on 25.05.2024.
//

import Foundation
import SwiftUI

class UniversalLMHalper {
    
    static let instanse = UniversalLMHalper()
    private let fileManager = FileManager.default
    private let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

    
    func saveFileDropBox(named fileName: String, from dropboxURL: URL, to directory: URL, completion: @escaping (Error?) -> Void) {
        let destinationURL = directory.appendingPathComponent(fileName)
        
        URLSession.shared.downloadTask(with: dropboxURL) { (tempURL, response, error) in
            if let error = error {
                completion(error)
                return
            }
            
            guard let tempURL = tempURL else {
                let error = NSError(domain: "Downloaded file URL is nil", code: 0, userInfo: nil)
                completion(error)
                return
            }
            
            do {
                if FileManager.default.fileExists(atPath: destinationURL.path) {
                    try FileManager.default.removeItem(at: destinationURL)
                }
                try FileManager.default.copyItem(at: tempURL, to: destinationURL)
                
                print("File saved successfully at: \(destinationURL.path)")
                completion(nil)
            } catch {
                completion(error)
            }
        }.resume()
    }
    
    func sharedItem(fileURL: URL)  {
        let item = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        let activeScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
        let rootViewController = (activeScene?.windows ?? []).first(where: { $0.isKeyWindow })?.rootViewController
        if UIDevice.current.userInterfaceIdiom == .pad {
            item.popoverPresentationController?.sourceView = rootViewController?.view
            item.popoverPresentationController?.sourceRect = .zero
        }
        rootViewController?.present(item, animated: true, completion: nil)
    }
    
    
    func saveImageToFile(image: UIImage, filename: String, savePath: String) {
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        let folderURL = documentsDirectory.appendingPathComponent(savePath)
        
        if !fileManager.fileExists(atPath: folderURL.path) {
            do {
                try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating directory:", error)
                return
            }
        }
        
        let fileURL = folderURL.appendingPathComponent(filename)
        do {
            try data.write(to: fileURL)
        } catch {
            print("Error saving image:", error)
        }
    }
    
    
    func loadImageFromFile(filename: String, savePath: String) -> UIImage? {
        let fileURL = documentsDirectory.appendingPathComponent(savePath + "/" + filename)
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return nil }
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image:", error)
            return nil
        }
    }
}
