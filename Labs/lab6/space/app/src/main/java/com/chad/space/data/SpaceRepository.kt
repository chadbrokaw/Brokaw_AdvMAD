package com.chad.space.data

import android.app.Application
import android.content.Context
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.Observer
import com.chad.space.utils.FileHelper
import com.chad.space.utils.NetworkHelper
import com.squareup.moshi.JsonAdapter
import com.squareup.moshi.Moshi
import com.squareup.moshi.Types
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory
import retrofit2.Retrofit
import retrofit2.converter.moshi.MoshiConverterFactory

class SpaceRepository(val app: Application) {
    private val listType = Types.newParameterizedType(List::class.java, Space::class.java)


    val spaceData = MutableLiveData<List<Space>>()
    val spaceDetails = MutableLiveData<SpaceDetails>()

    val spaceSelectedObserver = Observer<Space> {
        getSpaceDetails(it)
    }

    init {
        getSpaceData()
    }

    private fun getSpaceData() {

        val dataText = FileHelper.readTextFromAssets(app, "space-data.json")

        val moshi = Moshi.Builder().add(KotlinJsonAdapterFactory()).build()
        val adapter: JsonAdapter<List<Space>> = moshi.adapter(listType)

        spaceData.value = adapter.fromJson(dataText) ?: emptyList()
    }

    private fun getSpaceDetails(forSpace: Space) {
        val detailsText = FileHelper.readTextFromAssets(app, "sample-space-data.json")

        val moshi = Moshi.Builder().add(KotlinJsonAdapterFactory()).build()
        val adapter: JsonAdapter<SpaceDetails> = moshi.adapter(SpaceDetails::class.java)

        //update our LiveData object with the results of our parsing
        spaceDetails.value = adapter.fromJson(detailsText)
    }


}