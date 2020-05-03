package com.chad.mtracker.ui.addSpecificData

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import com.chad.mtracker.R

/**
 * A simple [Fragment] subclass.
 */
class AddSpecificData : Fragment() {


    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment

        val id = arguments?.getString("Id", "unknown")

        val dataManager = DataManager()
        val dataCustomizations = dataManager.getDataCustomizations(id)

        val root = inflater.inflate(R.layout.fragment_add_specific_data, container, false)
        root.findViewById<TextView>(R.id.dataTypeTitle).text = dataCustomizations.title


        return root
    }
}
