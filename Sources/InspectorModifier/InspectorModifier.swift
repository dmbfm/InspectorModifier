
import SwiftUI

public struct InspectorViewModifier<V: View>: ViewModifier {
    @Binding var isPresented: Bool
    @ViewBuilder let inspectorContent: () -> V

    @State private var sizePreference = InspectorColumnWidthValue.default
    @State var width: CGFloat = 0
    @State var translation: CGFloat = 0
}

extension InspectorViewModifier {
    init(_ isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> V) {
        _isPresented = isPresented
        inspectorContent = content
    }
}

extension InspectorViewModifier {
    public func body(content: Content) -> some View {
        HStack(spacing: 0) {
            content

            divider

            Group {
                let newWidth = width - translation
                inspectorContent()
                    //.offset(x: isPresented ? 0 : newWidth)
                    .frame(width: isPresented ? max(0, newWidth) : 0)
                    //.frame(width: max(0, newWidth))

            }
        }
        .onPreferenceChange(InspectorColumnWidthPreference.self) { value in
            sizePreference = value
        }
        .animation(.default, value: isPresented)
        .onAppear {
            width = sizePreference.ideal
        }
    }

    var divider: some View {
        Color(nsColor: NSColor.separatorColor)
            .frame(width: isPresented ? 2 : 0)
            .gesture(DragGesture(coordinateSpace: .global)
                .onChanged(self.onDividerDrag)
                .onEnded(self.onDividerDragEnded))
        #if os(macOS)
            .onHover { value in
                if value {
                    NSCursor.resizeLeftRight.push()
                } else {
                    NSCursor.pop()
                }
            }
        #endif
    }
}

extension InspectorViewModifier {
    func onDividerDrag(_ value: DragGesture.Value) {
        let oldTranslation = translation

        translation = value.translation.width

        let newWidth = width - translation
        if newWidth < sizePreference.min {
            isPresented = false
            translation = 0
        } else if newWidth >= sizePreference.max {
            translation = oldTranslation
        }
    }

    func onDividerDragEnded(_ value: DragGesture.Value) {
        width = width - translation
        translation = 0
    }
}

struct InspectorColumnWidthValue: Equatable {
    var ideal: CGFloat
    var min: CGFloat
    var max: CGFloat

    init(ideal: CGFloat, min: CGFloat? = nil, max: CGFloat? = nil) {
        self.ideal = ideal
        self.min = min ?? 50
        self.max = max ?? 300
    }

    static let `default` = InspectorColumnWidthValue(ideal: 150, min: 50, max: 300)
}

struct InspectorColumnWidthPreference: PreferenceKey {
    static var defaultValue = InspectorColumnWidthValue.default

    static func reduce(value: inout InspectorColumnWidthValue, nextValue: () -> InspectorColumnWidthValue) {
        value = nextValue()
    }
}

public extension View {
    func inspectorColumnWidth(_ value: CGFloat) -> some View {
        preference(key: InspectorColumnWidthPreference.self, value: InspectorColumnWidthValue(ideal: value))
    }

    func inspectorColumnWidth(min: CGFloat?, ideal: CGFloat, max: CGFloat?) -> some View {
        preference(key: InspectorColumnWidthPreference.self, value: InspectorColumnWidthValue(ideal: ideal, min: min, max: max))
    }
}

public extension View {
    func inspector<V: View>(_ isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> V) -> some View {
        modifier(InspectorViewModifier(isPresented, content: content))
    }
}
