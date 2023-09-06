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
    @State private var navItem: NavigationItem? = .all
    @State private var selectedCharacter: UUID?
    @State private var showInspector = false

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
            case .none:
                return []
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
            #if os(iOS)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                    showInspector.toggle()
                    } label: { Image(systemName: "info.circle")}
                    
                }
            }
            #endif
        } detail: {
                
                //Color.teal.opacity(0.25)
                
                List(selection: $selectedCharacter) {
                    ForEach(visibleItems) { item in
                        Text(item.name)
                    }
                }
            #if os(macOS)
                .listStyle(.inset(alternatesRowBackgrounds: true))
            #endif
                .navigationTitle(navItem?.rawValue ?? "")
                .inspector($showInspector) {
                    Group {
                        ZStack {
                            #if os(macOS)
                            Color.white
                            #else
                            //Color.teal.opacity(0.1)
                            Color.clear
                            #endif
                            Group {
                                if let selectedCharacterData = selectedCharacterData {
                                    characterDetailView(selectedCharacterData)
                                } else {
                                    VStack {
                                        Text("No Character Selected")
                                            .font(.largeTitle)
                                            .fontDesign(.rounded)
                                        Spacer()
                                    }
                                    .padding()
                                }
                            }
                            #if os(iOS)
                            .padding(.top, 55)
                            #endif
                        }
                    }
                    #if os(iOS)
                    .inspectorDividerIgnoresSafeArea()
                    .ignoresSafeArea()
                    #endif
                    .inspectorColumnWidth(min: 50, ideal: 300, max: 400)
                }
        }
        #if os(macOS)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showInspector.toggle()
                } label: { Image(systemName: "info.circle")}
            }
        }
        #endif
    }
    
    @ViewBuilder
    func characterDetailView(_ char: Character) -> some View {
        VStack(alignment: .leading) {
            Text(char.name)
                .font(.largeTitle)
                .fontDesign(.rounded)
                .padding(.vertical)
            
            Text(char.description)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
