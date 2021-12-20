//
//  DatabaseManager.swift
//  ChillGram
//
//  Created by Youssef Bhl on 26/11/2021.
//

import FirebaseDatabase

public class DatabaseManager {
    
    
    
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
    //MARK: - Public
    
    ///check if username and email are availble
    ///- Parameters
    ///     -email : String representing email
    ///     -username : String representing username
    public func canCreateNewUser(with email: String, username: String, password: String, completition : (Bool)->Void ) {
        completition(true)
    }
    
    ///insert a new user into the database
    ///- Parameters
    ///     -email : String representing email
    ///     -username : String representing username
    ///     -completion; Async call back for resilt if insert succeded
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool)-> Void) {
        database.child(email.safeDatabaseKey()).setValue(["username": username]){error, _ in
            if error != nil {
                completion(true)
                return
            }
            else {
                completion(false)
                return
            }
        }
    }
}

