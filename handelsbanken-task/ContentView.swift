import SwiftUI

struct ContentView: View {
    @State var viewModel = ContentViewModel()
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                loadingView()
                
            case .success(let resource):
                mainView(resource: resource)
                
            case .error:
                errorView()
            }
        }
        .task {
            await viewModel.fetchData()
        }
    }
    
    func loadingView() -> some View {
        ProgressView()
    }
    
    func mainView(resource: Resource) -> some View {
        VStack(spacing: 16) {
            Text(resource.text)
            
            Button("Refresh", action: refresh)
        }
    }
    
    func errorView() -> some View {
        EmptyView()
    }
    
    private func refresh() {
        Task {
            await viewModel.fetchData()
        }
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
