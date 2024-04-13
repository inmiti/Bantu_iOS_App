//
//  Network.swift
//  Bantu_iOS
//
//  Created by Silvia Casanova Martinez on 12/4/24.
//

import Foundation

enum NetworkModel {
    case registerUser(user: User)
    case login(email: String, password: String)
    case getCoach(coach: [Coach])
    case updateUser(user: User)
}

extension NetworkModel {
    var bantuURL: String {
        return "https://bantubackend-dev-tnqr.2.ie-1.fl0.io" }
    var baseURL: String {
        switch self {
        case .login,
                .getCoach,
                .registerUser,
                .updateUser:
            return bantuURL
        }
    }
    var path: String {
        switch self {
        case .login:
            return "/api/auth/signin"
        case .getCoach:
            return ""
        case .registerUser:
            return ""
        case .updateUser:
            return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login,
                .getCoach:
            return .get
        case .registerUser:
            return .post
        case .updateUser:
            return .put
        }
    }
    
    var query: [URLQueryItem]? {
        switch self {
        default:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .registerUser(let user), .updateUser(let user):
            let user = user
            return try? JSONEncoder().encode(user)
        case .login(let email, let password):
            return try? JSONEncoder().encode(["email" : email, "password" : password])
        case .getCoach(let coach):
            let coach = coach
            return try? JSONEncoder().encode(coach)
        }
    }
    
    var headers: [String: String]? {
        var header = NetworkModel.defaultHeaders
        if let body {
            header["Content-Length"] = "\(body.count)"
        }
        switch self {
            
        default: ()
        }
        return header
    }
    
    private static var defaultHeaders: [String: String] {
        return [
            "Accept": "application/json",
            "Content-Type": "application/json",
        ]
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

extension URLRequest {
    static func request(networkRequest: NetworkModel) -> URLRequest {
        var bodyString = ""
        var comps = URLComponents(string: networkRequest.baseURL)
        comps?.path = networkRequest.path
        var request = URLRequest(url: (comps?.url)!)
        if let query = networkRequest.query {
            comps?.queryItems = query
        }
        if let body = networkRequest.body {
            request.httpBody = body
            bodyString = String(data: networkRequest.body!, encoding: .utf8) ?? ""
        }
        request.httpMethod = networkRequest.method.rawValue
        request.allHTTPHeaderFields = networkRequest.headers
        print("💡 Headers: \(request.allHTTPHeaderFields ?? ["":""])")
        print("🚀", networkRequest.method.rawValue, comps?.url ?? "", networkRequest.query ?? "", bodyString)
        return request
    }
}


