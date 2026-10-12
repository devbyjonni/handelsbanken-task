import SwiftUI

struct ContentView: View {
    @State var viewModel = ContentViewModel()

    var body: some View {
        switch viewModel.state {
        case .loading:
            loadingView()
        case .success:
            mainView()
        case .error:
            errorView()
        }
    }

    func loadingView() -> some View {
        // TODO: Add loading indicator
        return EmptyView()
    }

    func mainView() -> some View {
        // TODO: Add content from state and a button to refresh

        VStack(spacing: 16) {
            Text("Some text")
            // TODO: Add a way to navigate to DetailView using NavigationStack
        }
    }

    func errorView() -> some View {
        // TODO: Add error message and a button to refresh
        return EmptyView()
    }
}

struct DetailView: View {
    // TODO: Populate with text from result
    let text: String

    var body: some View {
        Text(text)
    }
}

#Preview {
    let resource = Resource(time: Date.now.timeIntervalSince1970, text: "En sån sida")
    let viewModel = ContentViewModel(state: .success(resoure: resource))

    ContentView(viewModel: viewModel)
}
