import SwiftUI

enum ContentState {
    case loading
    case success(resoure: Resource)
    case error(message: String)
}

@Observable
class ContentViewModel {
    var state: ContentState
    let repository = Repository()

    init(state: ContentState = .loading) {
        self.state = state
    }

    func fetchData() async {
        state = .loading

        let response = await repository.fakeGetData()

        switch response {
        case .success(let resource):
            state = .success(resoure: resource)

        case .error(let message):
            state = .error(message: message)
        }
    }
}
