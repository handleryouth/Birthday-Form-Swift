//
//  ContentView.swift
//  Birthdays
//
//  Created by Tony Gultom on 13/08/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
//    @State private var friends: [Friend] = [
//        Friend(name: "Elton Lin", birthday: .now),
//        Friend(name: "Jenny Court", birthday: Date(timeIntervalSince1970: 0))
//    ]
    
    
    /*
     When you update the instances of Friend stored in SwiftData, the
     query updates your views, just like a @State property does
     
     @Query provides live updates to SwiftUI.
     
     */
    
    @Query private var friends: [Friend]
    
    /*
     
     A ModelContext provides a connection between the view and the
     model container so that you can fetch, insert, and delete items in the container.
     */
    
    @Environment(\.modelContext) private var context
    
    
    @State private var newName = ""
    @State private var newDate = Date.now
    
    
    var body: some View {
        NavigationStack {
            List(friends, id: \.name) {
                friend in HStack {
                    Text(friend.name)
                    Spacer()
                    Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                }
            }.navigationTitle("Birthdays!").safeAreaInset(edge: .bottom) {
                VStack(alignment: .center, spacing: 20) {

                                   Text("New Birthday")

                                       .font(.headline)
                    
                    
                    DatePicker(selection: $newDate, in: Date.distantPast...Date.now, displayedComponents: .date) {
                        TextField("Name", text: $newName).textFieldStyle(.roundedBorder)
                    }
                    
                    
                    Button("Save") {
                        let newFriend = Friend(name: newName, birthday: newDate)
                        
                        
                        context.insert(newFriend)
//                        friends.append(newFriend)
                        
                        newName = ""
                        newDate = .now
                    }.bold()

                }.padding().background(.bar)
            }.task {
                /*
                 Re-create your sample data inside a .task,
                 then save the data into SwiftData.
                 
                 SwiftUI begins executing the code in a .task before the view appears.
                 
                 */
                context.insert(Friend(name: "Elton Lin", birthday: .now))

                context.insert(Friend(name: "Jenny Court", birthday: Date(timeIntervalSince1970: 0)))
            }
        }
     
    }
}

#Preview {
    ContentView().modelContainer(for: Friend.self, inMemory: true)
}
