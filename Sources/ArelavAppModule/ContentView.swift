import SwiftUI
import ArelavSwiftTools


struct ContentView: View {
    @State var name: String = "World"
    @State var data: [MockAPIEcho]? = nil
    @State var networkError: String? = nil
    
    var body: some View {
        Form {
            Section("Logger") {
                Text("Hello, \(name)!")
                Button("Change") {
                    name = "there"
                    let logger = Log.shared
                    logger.logLevel = .Debug
                    logger.Debug(msg: "Hi")
                }    
            }
            Section("Network") {
                Button("Load data") {
                    getData()
                }
                if let networkError {
                    Text(networkError)
                        .foregroundStyle(.red)
                        .font(.headline)
                }
                if let data {
                    List(data) { item in
                        HStack {
                            Text(item.id).font(.caption).foregroundStyle(.gray)
                            Spacer()
                            Text(item.name).font(.headline)
                            Spacer()
                        }
                    }
                }
            }  
            
        }.frame(maxWidth: 500)
    }
    
    func getData() {
        Task {
            Log.shared.logLevel = .Debug
            let response = await MockAPIServices().getUsers()
            
            switch response {
            case .success(let success):
                data = success
                networkError = nil
            case .failure(let failure):
                networkError = failure.customMessage
                data = nil
            }    
        }
    }
}
