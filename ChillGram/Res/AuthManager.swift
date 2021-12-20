//
//  AuthManager.swift
//  ChillGram
//
//  Created by Youssef Bhl on 26/11/2021.
//

import FirebaseAuth
    
public class AuthManager {

    static let shared = AuthManager()

    //MARK: - Public

    public func registerNewUser(username: String, email:String, password:String, completition: @escaping (Bool)->Void) {
        /*
         steps :
         - check if username is available
         - check if email is available
         */
        DatabaseManager.shared.canCreateNewUser(with: email, username: username, password: password) { canCreat in
            if canCreat {
                /*
                 - creat account
                 - insert account to database
                 */
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil else {
                        //couldn't creat account
                        return
                    }
                    // insert in database
                    DatabaseManager.shared.insertNewUser(with: email, username: username){ inserted in
                        if inserted {
                            completition(true)
                            return
                        }
                        else {
                            //failed to insert to database
                            completition(false)
                            return
                        }
                    }
                    completition(true)
                }
                completition(true)
            }
            
            else {
                // either username and email does not exist
                completition(false)
            }
        }
    }
    
    public func loginUser(username: String?, email:String?, password:String, completion: @escaping (Bool) -> Void){
        if let email = email {
            // login with email
            Auth.auth().signIn(withEmail: email, password: password){ authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        }
        else if let username = username {
            // username login
            print("\(username)")

        }
    }
    
    // Logging Out the user
    public func LogOutUser(Completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            Completion(true)
        }
        catch {
            print(error)
            Completion(false)
        }
    }
}
