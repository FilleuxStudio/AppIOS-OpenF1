//
//  APIService.swift
//  OpenF1SwiftUI
//
//  Created by etudiant on 17/09/2024.
//
import Foundation

class APIService {
    private let baseURL = "https://api.openf1.org/v1"
    
    enum APIError: Error {
        case invalidURL
        case noData
        case decodingError
    }
    
    func fetchDrivers(sessionKey: Int, completion: @escaping (Result<[Driver], Error>) -> Void) {
        let endpoint = "/drivers"
        let queryItems = [URLQueryItem(name: "session_key", value: String(sessionKey))]
        performRequest(endpoint: endpoint, queryItems: queryItems, completion: completion)
    }
    
    func fetchMeetings(year: Int, countryName: String, completion: @escaping (Result<[Meeting], Error>) -> Void) {
        let endpoint = "/meetings"
        let queryItems = [
            URLQueryItem(name: "year", value: String(year)),
            URLQueryItem(name: "country_name", value: countryName)
        ]
        performRequest(endpoint: endpoint, queryItems: queryItems, completion: completion)
    }
    
    func fetchSessions(year: Int, country_code: String, completion: @escaping (Result<[Session], Error>) -> Void) {
        let endpoint = "/sessions"
        let queryItems = [
            URLQueryItem(name: "year", value: String(year)),
            URLQueryItem(name: "country_code", value: country_code),
            
        ]
        performRequest(endpoint: endpoint, queryItems: queryItems, completion: completion)
    }
    
    func fetchSessionsDateNow(year: Int, completion: @escaping (Result<[Session], Error>) -> Void) {
        let endpoint = "/sessions"
        let queryItems = [
            URLQueryItem(name: "year", value: String(year)),
        ]
        performRequest(endpoint: endpoint, queryItems: queryItems, completion: completion)
    }
    
    func fetchTeamRadio(date: String, driverNumber: Int, completion: @escaping (Result<[TeamRadio], Error>) -> Void) {
        let endpoint = "/team_radio"
        let queryItems = [
            URLQueryItem(name: "date", value: String(date)),
            URLQueryItem(name: "driver_number", value: String(driverNumber))
        ]
        performRequest(endpoint: endpoint, queryItems: queryItems, completion: completion)
    }
    
    func fetchCarData(driverNumber: Int, sessionKey: Int, minSpeed: Int, completion: @escaping (Result<[CarData], Error>) -> Void) {
        let endpoint = "/car_data"
        let queryItems = [
            URLQueryItem(name: "driver_number", value: String(driverNumber)),
            URLQueryItem(name: "session_key", value: String(sessionKey)),
            URLQueryItem(name: "speed", value: String(minSpeed)),
        ]
        //let speedQueryString = "speed>=\(minSpeed)"

        performRequest(endpoint: endpoint, queryItems: queryItems, completion: completion)
    }
    
    private func performRequest<T: Decodable>(endpoint: String, queryItems: [URLQueryItem], completion: @escaping (Result<[T], Error>) -> Void) {
        guard var urlComponents = URLComponents(string: baseURL + endpoint) else {
            completion(.failure(APIError.invalidURL))
            return
        }
                
        urlComponents.queryItems = queryItems
                
        guard let url = urlComponents.url else {
            completion(.failure(APIError.invalidURL))
            return
        }
        print("URL : \(url)")
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([T].self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(APIError.decodingError))
            }
        }.resume()
    }
}
