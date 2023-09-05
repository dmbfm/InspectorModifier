//
//  ContentView.swift
//  InspectorModifierDemo
//
//  Created by Daniel Fortes on 05/09/23.
//

import InspectorModifier
import SwiftUI

enum NavigationItem: String {
    case all = "All Characters"
    case mystery = "Mystery"
    case fantasy = "Fantasy"
    case scifi = "Science Fiction"
}

struct ContentView: View {
    @State private var navItem: NavigationItem = .all
    @State private var selectedCharacter: UUID?
    @State private var showInspector = true

    var visibleItems: [Character] {
        switch navItem {
            case .all:
                return Character.allCharacters
            case .mystery:
                return Character.detectiveCharacters
            case .fantasy:
                return Character.fantasyCharacters
            case .scifi:
                return Character.sciFiCharacters
        }
    }
    
    var selectedCharacterData: Character? {
        Character.allCharacters.first(where: { $0.id == selectedCharacter })
    }

    var body: some View {
        NavigationSplitView {
            List(selection: $navItem) {
                Label("All Characters", systemImage: "house")
                    .tag(NavigationItem.all)

                Section("By Genre") {
                    Label("Mystery", systemImage: "magnifyingglass")
                        .tag(NavigationItem.mystery)

                    Label("Fantasy", systemImage: "mountain.2.fill")
                        .tag(NavigationItem.fantasy)

                    Label("Science Fiction", systemImage: "airpods.chargingcase.fill")
                        .tag(NavigationItem.scifi)
                }
            }

            .navigationSplitViewColumnWidth(min: 50, ideal: 200, max: 300)
        } detail: {
            List(selection: $selectedCharacter) {
                ForEach(visibleItems) { item in
                    Text(item.name)
                }
            }

            .listStyle(.inset(alternatesRowBackgrounds: true))
            .navigationTitle(navItem.rawValue)
            .inspector($showInspector) {
                Group {
                    if let selectedCharacterData = selectedCharacterData {
                        characterDetailView(selectedCharacterData)
                    } else {
                        VStack {
                            Text("No Character Selected")
                                .font(.largeTitle)
                            Spacer()
                        }
                        .padding()
                    }
                }
                .inspectorColumnWidth(min: 50, ideal: 300, max: 400)
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showInspector.toggle()
                } label: { Image(systemName: "info.circle")}
            }
        }
    }
    
    @ViewBuilder
    func characterDetailView(_ char: Character) -> some View {
        VStack(alignment: .leading) {
            Text(char.name)
                .font(.largeTitle)
                .padding()
            
            Text(char.description)
            
            Spacer()
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
