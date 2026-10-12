import Foundation

enum Response {
    case success(resource: Resource)
    case error(message: String)
}

class Resource {
    let time: TimeInterval
    let text: String

    init(time: TimeInterval, text: String) {
        self.time = time
        self.text = text
    }
}

class Repository {
    // This is just a function that fakes getting data from an unreliable service
    func fakeGetData() async -> Response {
        try? await Task.sleep(nanoseconds: 1_000_000_000)

        if Bool.random() {
            let resource = Resource(time: Date.now.timeIntervalSince1970, text: "Ny data")
            return .success(resource: resource)
        } else {
            return .error(message: "Some error")
        }
    }
}
