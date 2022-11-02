package com.desmond.kotlin.multiplatform.mykmmnoteapp.data.local

import com.squareup.sqldelight.db.SqlDriver

expect class DatabaseDriverFactory {
    fun createDriver(): SqlDriver
}