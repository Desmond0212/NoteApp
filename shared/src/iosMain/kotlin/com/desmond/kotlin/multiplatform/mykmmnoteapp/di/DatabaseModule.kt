package com.desmond.kotlin.multiplatform.mykmmnoteapp.di

import com.desmond.kotlin.multiplatform.mykmmnoteapp.data.local.DatabaseDriverFactory
import com.desmond.kotlin.multiplatform.mykmmnoteapp.data.note.SqlDelightNoteDataSource
import com.desmond.kotlin.multiplatform.mykmmnoteapp.database.NoteDatabase
import com.desmond.kotlin.multiplatform.mykmmnoteapp.domain.note.NoteDataSource

class DatabaseModule {
    private val factory by lazy { DatabaseDriverFactory() }
    val noteDataSource: NoteDataSource by lazy {
        SqlDelightNoteDataSource(NoteDatabase(factory.createDriver()))
    }
}