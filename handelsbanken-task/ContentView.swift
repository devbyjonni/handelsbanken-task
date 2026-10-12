import SwiftUI

struct ContentView: View {
    @State var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack {
            switch viewModel.state {
            case .loading:
                loadingView()
            case .success(let resource):
                mainView(resource: resource)
            case .error(let message):
                errorView(message: message)
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
            
            NavigationLink {
                DetailView(resource: resource)
            } label: {
                Text("Show details")
            }
        }
    }
    
    func errorView(message: String) -> some View {
        VStack(spacing: 16) {
            Text(message)
            
            Button("Try again", action: refresh)
        }
    }
    
    private func refresh() {
        Task {
            await viewModel.fetchData()
        }
    }
}

struct DetailView: View {
    let resource: Resource
    
    var body: some View {
        VStack(spacing: 16) {
            Text(resource.text)
            
            Text(
                Date(timeIntervalSince1970: resource.time),
                style: .date
            )
            
            Text(
                Date(timeIntervalSince1970: resource.time),
                style: .time
            )
        }
    }
}

#Preview {
    let resource = Resource(time: Date.now.timeIntervalSince1970, text: "En sån sida")
    let viewModel = ContentViewModel(state: .success(resoure: resource))
    
    ContentView(viewModel: viewModel)
}
