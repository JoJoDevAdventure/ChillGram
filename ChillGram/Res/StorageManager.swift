//
//  StorageManager.swift
//  ChillGram
//
//  Created by Youssef Bhl on 26/11/2021.
//

import FirebaseStorage
import UIKit

public class StorageManager {
    
    static let shared = StorageManager()
    private let bucket = Storage.storage().reference()
    public enum CGstorageManagerError : Error {
        case failedToDownload
    }
    
    //MARK: - Public
    
    public func uploadUserPost(model: UserPost, completion: (Result<URL, Error>) -> Void) {
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, CGstorageManagerError>) -> Void) {
        bucket.child(reference).downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                completion(.failure(.failedToDownload))
                return
            }
            
            completion(.success(url))
        })
        
    }
}

