/// An atom type that provides a throwing `Task` from the given asynchronous, throwing function.
///
/// This atom guarantees that the task to be identical instance and its state can be shared
/// at anywhere even when they are accessed simultaneously from multiple locations.
///
/// - SeeAlso: ``TaskAtom``
/// - SeeAlso: ``Suspense``
///
/// ## Output Value
///
/// Task<Self.Value, Error>
///
/// ## Example
///
/// ```swift
/// struct AsyncTitleAtom: ThrowingTaskAtom, Hashable {
///     func value(context: Context) async throws -> String {
///         try await Task.sleep(nanoseconds: 1_000_000_000)
///         return "The Atomic Architecture"
///     }
/// }
///
/// struct DelayedTitleView: View {
///     @Watch(AsyncTitleAtom())
///     var title
///
///     var body: some View {
///         Suspense(title) { title in
///             Text(title)
///         } suspending: {
///             Text("Loading")
///         } catch: {
///             Text("Failed")
///         }
///     }
/// }
/// ```
///
public protocol ThrowingTaskAtom: Atom where Hook == ThrowingTaskHook<Value> {
    /// The type of value that this atom produces.
    associatedtype Value

    /// Asynchronously produces a value that to be provided via this atom.
    ///
    /// This asynchronous method is converted to a `Task` internally, and if it will be
    /// cancelled by downstream atoms or views, this method will also be cancelled.
    ///
    /// - Parameter context: A context structure that to read, watch, and otherwise
    ///                      interacting with other atoms.
    ///
    /// - Throws: The error that occurred during the process of creating the resulting value.
    ///
    /// - Returns: A throwing `Task` that produces asynchronous value.
    @MainActor
    func value(context: Context) async throws -> Value
}

public extension ThrowingTaskAtom {
    @MainActor
    var hook: Hook {
        Hook(value: value)
    }
}
