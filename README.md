# InspectorModifier

Since the inspector modifier is only available for macOS 15 and iOS 17 I made a
small replacement for use in earlier versions. It is focused mostly for macOS
use. On iPad it is janky but works. On iPhone it does not currently work well.

# Usage 

```swift 
struct ContentView: View {

    @State var isPresented = false

    var body: some View {
        VStack {
            Text("Main View")
            Button("Toggle Inspector") {
                isPresented.toggle()            
            }
        }.inspector(isPresented: $isPresented) {
            Text("Inspector")
                .inspectorColumnWidth(min: 50, ideal: 200, max: 300)
        }
    }
}
```

# Todo

- [ ] Use modal sheet on iPhone.

