package com.chad.mtracker.ui.macros

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class MacrosViewModel : ViewModel() {

    private val _text = MutableLiveData<String>().apply {
        value = "Show your macros"
    }
    val text: LiveData<String> = _text
}