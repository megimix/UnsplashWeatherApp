import Foundation
import Result

open class UrlRequestDispatcher {

    // MARK: - Attributes

    let configuration: URLSessionConfiguration

    // MARK: - Singleton

    public static var instance: UrlRequestDispatcher = UrlRequestDispatcher()

    // MARK: - Init

    public init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.configuration = configuration
    }

    // MARK: - Public

    public func dispatch(request: URLRequest,
                         completionQueue: DispatchQueue = DispatchQueue.main,
                         completion: @escaping (Result<(Data, URLResponse), NSError>) -> Void) {
        let session = URLSession(configuration: self.configuration)
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            completionQueue.async {
                if let error = error {
                    completion(.failure(error as NSError))
                } else if let data = data, let response = response {
                    completion(.success((data, response)))
                }
            }
        })
        dataTask.resume()
    }

}
