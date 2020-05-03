package com.chad.mtracker

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup

/**
 * A simple [Fragment] subclass.
 */
class AddSpecificData : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        val id = arguments?.getString("Id")

        Log.e("SpecificData", id)

        return inflater.inflate(R.layout.fragment_add_specific_data, container, false)
    }

}
