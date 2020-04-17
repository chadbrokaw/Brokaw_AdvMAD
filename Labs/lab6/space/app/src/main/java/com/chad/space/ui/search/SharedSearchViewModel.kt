package com.chad.space.ui.search

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.chad.space.data.Space
import com.chad.space.data.SpaceRepository
import com.chad.space.utils.FileHelper

class SharedSearchViewModel(app: Application) : AndroidViewModel(app) {
    //instantiate repository class
    private val spaceRepo = SpaceRepository(app)

    //get reference to LiveData object with a value of type List<Recipe>
    val spaceData = spaceRepo.spaceData
    val selectedSpace = MutableLiveData<Space>()
    val spaceDetails = spaceRepo.spaceDetails

    init {
        selectedSpace.observeForever(spaceRepo.spaceSelectedObserver)
    }

    override fun onCleared() {
        //remove observers added with observe forever to prevent memory leak
        selectedSpace.removeObserver(spaceRepo.spaceSelectedObserver)
        super.onCleared()
    }

    private val _text = MutableLiveData<String>().apply {
        value = "This is the Search Fragment"
    }
    val text: LiveData<String> = _text
}