//
//  URLSessionProvider.swift
//  LuckyTrip
//
//  Created by Abdullah Munzer on 06/08/2022.
//
import Foundation

final class URLSessionProvider: ProviderProtocol {

    private var session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func request<T>(type: T.Type, service: ServiceProtocol, completion: @escaping (NetworkResponse<T>) -> Void) where T: Decodable {
        let request = URLRequest(service: service)

        let task = session.dataTask(request: request, completionHandler: { [weak self] data, response, error in
            let httpResponse = response as? HTTPURLResponse
            self?.handleDataResponse(data: data, response: httpResponse, error: error, completion: completion)
        })
        print(task.curlCommand)
        task.resume()
    }

    private func handleDataResponse<T: Decodable>(data: Data?, response: HTTPURLResponse?, error: Error?, completion: (NetworkResponse<T>) -> Void) {
        guard error == nil else { return completion(.failure(.unknown)) }
        guard let response = response else { return completion(.failure(.noJSONData)) }

        switch response.statusCode {
        case 200...299:
            guard let data = data, let model = try? JSONDecoder().decode(T.self, from: data) else { return completion(.failure(.unknown)) }
            completion(.success(model))
        case 400...599:
            guard let data = data, let model = try? JSONDecoder().decode(APIError.self, from: data) else {
                return completion(.failure(.unknown))
            }
            completion(.apiFailure(model))

        default:
            completion(.failure(.unknown))
        }
    }
}
extension DataTask {
    var curlCommand: String {
        var curlCmd = "curl -v "
        guard let request = currentRequest else { return "No request" }
        curlCmd += "-X \(request.httpMethod ?? "GET") \\\n"
        curlCmd += "    \"\(request.url?.absoluteString ?? "URL")\" \\\n"
        for (header, value) in request.allHTTPHeaderFields ?? [:] {
            curlCmd += "    -H \"\(header): \(value)\" \\\n"
        }
        if (request.httpMethod == "POST" || request.httpMethod == "PUT" || request.httpMethod == "PATCH") && request.httpBody != nil {
            var json = String(data: request.httpBody!, encoding: .utf8)!
            json = json.replacingOccurrences(of: " ", with: "")
            curlCmd += "    -d \'\(json)\' \\\n"
        }
        let lastBackslashRange = curlCmd.range(of: "\\", options: .backwards)!
        curlCmd = curlCmd.replacingCharacters(in: lastBackslashRange, with: "")
        return curlCmd
    }
}
protocol DataTask {
    var currentRequest: URLRequest? { get }
    func resume()
}

extension URLSessionDataTask: DataTask { }
