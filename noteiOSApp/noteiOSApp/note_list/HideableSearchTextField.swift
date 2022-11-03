//
//  HideableSearchTextField.swift
//  noteiOSApp
//
//  Created by Modefair Desmond on 02/11/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI

struct HideableSearchTextField<Destination : View> : View {
    
    var onSearchToggled : () -> Void
    var destinationProvider : () -> Destination
    var isSearchAcitve : Bool
    @Binding var searchText : String
    
    var body: some View {
        HStack {
            TextField("Search...", text : $searchText)
                .textFieldStyle(.roundedBorder)
                .opacity(isSearchAcitve ? 1 : 0)
            
            if !isSearchAcitve {
                Spacer()
            }
            
            Button(action : onSearchToggled) {
                Image(systemName: isSearchAcitve ? "xmark" : "magnifyingglass")
                    .foregroundColor(.black)
            }
            
            NavigationLink(destination : destinationProvider()) {
                Image(systemName: "plus")
                    .foregroundColor(.black)
            }
        }
    }
}

struct HideableSearchTextField_Previews: PreviewProvider {
    static var previews: some View {
        HideableSearchTextField(
            onSearchToggled: {},
            destinationProvider: { EmptyView() },
            isSearchAcitve: true,
            searchText: .constant("Hello World!")
        )
    }
}
