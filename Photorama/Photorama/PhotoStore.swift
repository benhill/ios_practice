import Foundation

enum PhotoResult {
    case success([Photo])
    case failure(Error)
}

class PhotoStore {
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchInterestingPhotos(completion: @escaping (PhotoResult) -> Void){
        let url = FlickrAPI.interestingPhotosURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request){
            (data, response, error) -> Void in
            
            let result = self.processPhotoRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    private func processPhotoRequest(data: Data?, error: Error?) -> PhotoResult {
        guard let jsonData = data else {
            return.failure(error!)
        }
        
        return FlickrAPI.photos(fromJson: jsonData)
    }
}
