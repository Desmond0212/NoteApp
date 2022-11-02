//
//  NoteListViewModel.swift
//  noteiOSApp
//
//  Created by Modefair Desmond on 02/11/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import Foundation
import shared

extension NoteListScreen {
    @MainActor class NoteListViewModel : ObservableObject {
        private var noteDataSource : NoteDataSource? = nil
        private let searchNotes = SearchNotes()
        
        private var notes = [Note]()
        @Published private(set) var fileteredNotes = [Note]()
        @Published var searchText = "" {
            didSet {
                self.fileteredNotes = searchNotes.execute(notes: self.notes, query: searchText)
            }
        }
        @Published private(set) var isSearchActive = false
        
        init(noteDataSource : NoteDataSource? = nil) {
            self.noteDataSource = noteDataSource
        }
        
        func loadNotes() {
            noteDataSource?.getAllNotes(completionHandler: { notes, error in
                self.notes = notes ?? []
                self.fileteredNotes = self.notes
            })
        }
        
        func deleteNoteById(id : Int64?) {
            if id != nil {
                noteDataSource?.deleteNoteById(id: id!, completionHandler: { error in
                    self.loadNotes()
                })
            }
        }
        
        func toggleIsSearchActive() {
            isSearchActive = !isSearchActive
            if !isSearchActive {
                searchText = ""
            }
        }
        
        func setNoteDataSource(noteDataSource : NoteDataSource) {
            self.noteDataSource = noteDataSource
//            noteDataSource.insertNote(note: Note(id: nil, title: "Note Title", content: "Note Content", colorHex: 0xFF2355, created: DateTimeUtil().now()), completionHandler: { error in
//
//            })
        }
    }
}
