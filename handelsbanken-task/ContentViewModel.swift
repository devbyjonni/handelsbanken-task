import SwiftUI

enum ContentState {
    case loading
    case success(resoure: Resource)
    case error(message: String)
}

@Observable
class ContentViewModel {
    var state: ContentState

    init(state: ContentState = .loading) {
        self.state = state
    }

    func fetchData() async {
        // TODO: Get data from the repository and to show on our UI
    }
}
