//
//  UserController.swift
//  Random Users
//
//  Created by Craig Swanson on 1/26/20.
//  Copyright © 2020 Erica Sadun. All rights reserved.
//

import Foundation
import UIKit

class UserController {
    
    // MARK: - Properties
    var results: [Friend] = []
    private let baseURL = URL(string: "https://randomuser.me/api/?format=json&inc=name,email,phone,picture&results=1000")
    
    // fetchUsers is called on the tableview's viewDidLoad and populates the array for the data source
    func fetchUsers(completion: @escaping (Error?) -> () = {_ in }) {
        var request = URLRequest(url: baseURL!)
        request.httpMethod = "GET"
        
        let fetchUsersTask = URLSession.shared.dataTask(with: request) { (possibleData, _, possibleError) in
            // TODO: Include defer when code moved to Operation class
            
            if possibleError != nil {
                print("Error in retrieving data from fetchUsers task: \(possibleError!)")
                return
            }
            
            guard let data = possibleData else {
                print("Bad data returned in fetchUsers task: \(possibleError!)")
                return
            }
            let decoder = JSONDecoder()
            do {
                let decodedUsers = try decoder.decode(FriendArray.self, from: data)
                self.results = decodedUsers.results
                completion(nil)
            } catch {
                print("Error decoding users: \(possibleError!)")
                completion(error)
                return
            }
        }
        fetchUsersTask.resume()
    }
    
    
    // Method is used to fetch the large image from the URL
    func fetchImage(at url: URL, completion: @escaping (Result<UIImage, Error>) -> ()) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching image from URL: \(error)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("Bad data in fetching image from URL: \(error!)")
                completion(.failure(NSError()))
                return
            }
            
            let image = UIImage(data: data)!
            completion(.success(image))
            return
        }.resume()
    }
}
