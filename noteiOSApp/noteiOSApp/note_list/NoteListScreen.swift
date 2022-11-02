//
//  NoteListScreen.swift
//  noteiOSApp
//
//  Created by Modefair Desmond on 02/11/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import shared

struct NoteListScreen: View {
    private var noteDataSrouce : NoteDataSource
    @StateObject var viewModel = NoteListViewModel(noteDataSource: nil)
    
    @State private var isNoteSelected = false
    @State private var selectedNoteId : Int64? = nil
    
    init(noteDataSource: NoteDataSource) {
        self.noteDataSrouce = noteDataSource
    }
    
    var body: some View {
        VStack {
            ZStack {
                NavigationLink(destination: NoteDetailScreen(noteDataSource: self.noteDataSrouce, noteId: selectedNoteId), isActive: $isNoteSelected) {
                    EmptyView()
                }.hidden()
                HideableSearchTextField<NoteDetailScreen>(onSearchToggled: {
                    viewModel.toggleIsSearchActive()
                }, destinationProvider: {
                    NoteDetailScreen(
                        noteDataSource: noteDataSrouce,
                        noteId: selectedNoteId
                    )
                }, isSearchAcitve: viewModel.isSearchActive, searchText:
                                            $viewModel.searchText)
                .frame(maxWidth: .infinity, minHeight: 40)
                .padding()
                
                if !viewModel.isSearchActive {
                    Text("All notes")
                        .font(.title2)
                }
            }
            
            List {
                ForEach(viewModel.fileteredNotes, id: \.self.id) { note in
                    Button(action: {
                        isNoteSelected = true
                        selectedNoteId = note.id?.int64Value
                    }) {
                        NoteItem(note : note, onDeleteClick: {
                            viewModel.deleteNoteById(id: note.id?.int64Value)
                        })
                    }
                }
            }
            .onAppear {
                viewModel.loadNotes()
            }
            .listStyle(.plain)
            .listRowSeparator(.hidden)
        }
        .onAppear {
            viewModel.setNoteDataSource(noteDataSource: noteDataSrouce)
        }
    }
}

struct NoteListScreen_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
