import Atoms
import ExampleCounter
import ExampleTodo
import SwiftUI

// swift-format-ignore: AllPublicDeclarationsHaveDocumentation
public struct CrossPlatformApp: App {
    public init() {}

    public var body: some Scene {
        WindowGroup {
            AtomRoot {
                NavigationView {
                    List {
                        NavigationLink("🔢 Counter") {
                            ExampleCounter()
                        }

                        NavigationLink("📋 Todo") {
                            ExampleTodo()
                        }
                    }
                    .navigationTitle("Examples")

                    #if os(iOS)
                        .listStyle(.insetGrouped)
                    #endif
                }

                #if os(iOS)
                    .navigationViewStyle(.stack)
                #endif
            }
        }
    }
}
