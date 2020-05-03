package com.chad.mtracker.ui.addData

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.cardview.widget.CardView
import androidx.core.os.bundleOf
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.NavController
import androidx.navigation.Navigation
import com.chad.mtracker.R

class AddDataFragment : Fragment() {

    private lateinit var navController: NavController

    override fun onCreateView(
            inflater: LayoutInflater,
            container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        navController = Navigation.findNavController(requireActivity(), R.id.nav_host_fragment)

        val root = inflater.inflate(R.layout.fragment_add_data, container, false)

        val weightCard = root.findViewById<CardView>(R.id.weightCard)

        weightCard.setOnClickListener(object : View.OnClickListener {
            override fun onClick(v: View?) {
                var bundle = bundleOf("Id" to "Weight")
                navController.navigate(R.id.action_navigation_AddData_to_addSpecificData, bundle)
            }
        })

        return root
    }
}
