package com.desmond.kotlin.multiplatform.mykmmnoteapp.android.note_list

import com.desmond.kotlin.multiplatform.mykmmnoteapp.domain.note.Note

data class NoteListState(
    val notes: List<Note> = emptyList(),
    val searchText: String = "",
    val isSearchActive: Boolean = false
)
