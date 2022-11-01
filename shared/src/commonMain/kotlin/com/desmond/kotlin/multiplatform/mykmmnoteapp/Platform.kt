package com.desmond.kotlin.multiplatform.mykmmnoteapp

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform