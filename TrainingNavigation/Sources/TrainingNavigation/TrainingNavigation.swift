// The Swift Programming Language
// https://docs.swift.org/swift-book

// TrainingNavigationといっておきながらタブ間の連携

import SwiftUI
import SwiftData
import Observation

@Model
final class User: Equatable {
    var id: Int
    var name: String
    var isFollow: Bool
    init(id: Int, name: String, isFollow: Bool) {
        self.id = id
        self.name = name
        self.isFollow = isFollow
    }
}

//複数のViewModelにuserに更新があったことを通知するクラス
@Observable
final class UserNotification {
    static let `default` = UserNotification()
    private init() {}
    //通知するパラメータ
    var updateUser: User? = nil

}

@Observable
final class ViewModel {

    private var name: String = ""
    private(set) var users: [User] = []
    private(set) var loading: Bool = false
    private var fetched: Bool = false

    private let userNotification: UserNotification = .default
    private var registrar = ObservationRegistrar()

    init(name: String = "", users: [User] = [], loading: Bool = false, fetched: Bool = false) {
        self.name = name
        self.users = users
        self.loading = loading
        self.fetched = fetched

        self.userNotification.updateUser = nil

        self.observeChanges()
    }

    func fetchUsers() async {
        guard !fetched else { return }
        // 本来はAPIを叩いて取得
        loading = true
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        self.users = [
            User(id: 0, name: "Alice", isFollow: true),
            User(id: 1, name: "Bob", isFollow: false),
            User(id: 2, name: "Charlie", isFollow: true),
        ]
        print(self.users.compactMap(\.id))

        loading = false
        fetched = true
    }

    func toggleFollow(for user: User) {
        user.isFollow.toggle()
        // 更新があったらuserStateに通知
        userNotification.updateUser = user
    }

    private func observeChanges() {
        _ = withObservationTracking {
            userNotification.updateUser
        } onChange: {
            Task { @MainActor in
                /*
                 updateUserに新しい値がきて
                 同じidのuserがいて
                 !=なら更新
                 */
                self.users = self.users.compactMap({ user in
                    if let newUser = self.userNotification.updateUser, user.id == newUser.id, user != newUser  {
                        newUser
                    } else {
                        user
                    }
                })
                self.observeChanges()
            }
        }
    }
}

struct SampleView: View {

    @State private(set) var viewModel: ViewModel

    var body: some View {
        ZStack {
            List(viewModel.users) { user in
                HStack {
                    Text(user.name)
                    Spacer()
                    Button(action: {
                        self.viewModel.toggleFollow(for: user)
                    }) {
                        Text(user.isFollow ? "Followed" : "Follow")
                    }
                }
                .background(user.isFollow ? .green : Color.clear)
            }
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(1.5)
                .opacity(viewModel.loading ? 1 : 0)
        }
        .task {
            await self.viewModel.fetchUsers()
        }
    }
}

#Preview {
    TabView {
        SampleView(viewModel: ViewModel(name: "A"))
            .tabItem {
                Image(systemName: "house")
                Text("A")
            }
        SampleView(viewModel: ViewModel(name: "B"))
            .tabItem {
                Image(systemName: "person")
                Text("B")
            }
    }
}
