
import SwiftUI

public struct InspectorViewModifier<V: View>: ViewModifier {
    @Binding var isPresented: Bool
    @ViewBuilder let inspectorContent: () -> V

    @State private var sizePreference = InspectorColumnWidthValue.default
    @State var width: CGFloat = 0
    @State var translation: CGFloat = 0
    @State var divierIgnoresSafeArea = false
}

extension InspectorViewModifier {
    init(_ isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> V) {
        _isPresented = isPresented
        inspectorContent = content
    }
}

extension InspectorViewModifier {
    
    var invisibleDivider: some View {
        Color.clear
            .contentShape(Rectangle())
            .frame(width: 12)
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
    
    public func body(content: Content) -> some View {
        Group {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    content
                        .frame(width: isPresented ? nil : geometry.size.width)
                        
                        
                        if divierIgnoresSafeArea {
                            divider.ignoresSafeArea()
                        } else {
                            divider
                        }
                    
                        
                        Group {
                            ZStack(alignment: .topLeading) {
                                
                                invisibleDivider
                                    .zIndex(1)
                                
                                let newWidth = width - translation
                                inspectorContent()
                                    .frame(width: max(0, newWidth))
                            }
                        }
                    
                }
            }
        }
        .onPreferenceChange(DividerIgnoresSafeArea.self) { value in
            divierIgnoresSafeArea = value
        }
        .onPreferenceChange(InspectorColumnWidthPreference.self) { value in
            sizePreference = value
        }
        .animation(.default, value: isPresented)
        .onAppear {
            width = sizePreference.ideal
        }
    }
    
    #if canImport(AppKit)
    var dividerColor: Color { Color(nsColor: NSColor.separatorColor) }
    #else
    var dividerColor: Color { Color(uiColor: UIColor.separator) }
    #endif

    var divider: some View {
       dividerColor
            .frame(width: isPresented ? 1 : 0)
            
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

    func onDividerDragEnded(_: DragGesture.Value) {
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

struct DividerIgnoresSafeArea: PreferenceKey {
    static var defaultValue = false
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

public extension View {
    func inspectorDividerIgnoresSafeArea() -> some View {
        preference(key: DividerIgnoresSafeArea.self, value: true)
    }
}

public extension View {
    func inspector<V: View>(_ isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> V) -> some View {
        modifier(InspectorViewModifier(isPresented, content: content))
    }
}
