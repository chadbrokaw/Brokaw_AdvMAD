package com.chad.mtracker.ui.addData

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class AddDataViewModel : ViewModel() {

    private val _text = MutableLiveData<String>().apply {
        value = "This is where you add Data"
    }
    val text: LiveData<String> = _text
}