//
//  ContentView.swift
//  Erun
//
//  Created by Saad Qureshi on 04/05/2021.
//

import SwiftUI
import FirebaseDatabase

struct ContentView: View {
    @StateObject var vm: HomeVM = HomeVM()
    
    var body: some View {
        VStack {
            List(vm.events) { event in
                Text(event.title)
            }
        }
        .onAppear(perform: vm.onAppear)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
