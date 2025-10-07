import SwiftUI

@MainActor
class DataManager {

    static let shared = DataManager()

    // AppStorage（UserDefaults）に保存された下書きを確認する関数
    func checkAppStorageDraft(for itemID: Int) {
        let key = "appMessage_\(itemID)"
        let appDraft = AppStorage(wrappedValue: "", key)
        print("✅ [DataManager]: AppStorageのデータを発見！ -> '\(appDraft.wrappedValue)'")
    }

    // SceneStorageのデータを確認しようとするが、アクセス手段がないことを示す
    func checkSceneStorageDraft(for itemID: Int) {
        let key = "sceneMessage_\(itemID)"
        let sceneDraft = SceneStorage(wrappedValue: "", key)
        print("✅ [DataManager]: SceneStorageのデータを発見！ -> '\(sceneDraft.wrappedValue)'")
    }
}

// ----- ここから下はSwiftUIのView -----

public struct TrainingBasic: View {
    private let items: [Item] = (1...20).map { Item(id: $0, name: "アイテム \($0)") }
    
    public init() { }
    
    public var body: some View {
        NavigationStack {
            List(items) { item in
                NavigationLink(item.name, value: item)
            }
            .navigationTitle("リスト")
            .navigationDestination(for: Item.self) { item in
                DetailView(item: item)
            }
        }
    }
    
    struct DetailView: View {
        let item: Item
        
        @SceneStorage private var sceneDraft: String
        @AppStorage private var appDraft: String
        
        init(item: Item) {
            self.item = item
            // 両方とも、item.idを使って動的なキーで初期化する
            self._sceneDraft = SceneStorage(wrappedValue: "", "sceneMessage_\(item.id)")
            self._appDraft = AppStorage(wrappedValue: "", "appMessage_\(item.id)")
        }
        
        var body: some View {
            VStack(spacing: 20) {
                Text("\(item.name) の詳細").font(.largeTitle)
                
                VStack(alignment: .leading) {
                    Text("AppStorage (UserDefaults)").font(.headline)
                    TextEditor(text: $appDraft).border(Color.blue, width: 2)
                }
                
                VStack(alignment: .leading) {
                    Text("SceneStorage").font(.headline)
                    TextEditor(text: $sceneDraft).border(Color.green, width: 2)
                }
                
                // データを確認するためのボタン
                Button("外部のクラスからデータを確認する") {
                    print("\n--- 確認ボタンが押されました ---")
                    DataManager.shared.checkAppStorageDraft(for: item.id)
                    DataManager.shared.checkSceneStorageDraft(for: item.id)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                
                Spacer()
            }
            .padding()
            .navigationTitle(item.name)
        }
    }
    
    struct Item: Identifiable, Hashable {
        let id: Int
        let name: String
    }
}
