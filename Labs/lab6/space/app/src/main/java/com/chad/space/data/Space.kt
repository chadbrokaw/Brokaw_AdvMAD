package com.chad.space.data

data class Space (
    val date: String,
    val explanation: String,
    val hdurl: String,
    val title: String,
    val url: String
)

data class SpaceDetails (
    val date: String,
    val explanation: String,
    val hdurl: String,
    val title: String,
    val url: String,
    val media_type: String,
    val service_version: String
)
