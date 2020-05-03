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
import com.chad.mtracker.ui.addSpecificData.DataTypes

class AddDataFragment : Fragment() {

    private lateinit var navController: NavController

    override fun onCreateView(
            inflater: LayoutInflater,
            container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        navController = Navigation.findNavController(requireActivity(), R.id.nav_host_fragment)

        val root = inflater.inflate(R.layout.fragment_add_data, container, false)

        root.findViewById<CardView>(R.id.weightCard).setOnClickListener { navigateAway(DataTypes.WEIGHT) }
        root.findViewById<CardView>(R.id.heightCard).setOnClickListener { navigateAway(DataTypes.HEIGHT) }
        root.findViewById<CardView>(R.id.activityLevelCard).setOnClickListener { navigateAway(DataTypes.ACTIVITY_LEVEL) }
        root.findViewById<CardView>(R.id.bfpCard).setOnClickListener { navigateAway(DataTypes.BODY_FAT_PERCENTAGE) }
        root.findViewById<CardView>(R.id.waistCard).setOnClickListener { navigateAway(DataTypes.WAIST_SIZE) }
        root.findViewById<CardView>(R.id.chestCard).setOnClickListener { navigateAway(DataTypes.CHEST_SIZE) }
        root.findViewById<CardView>(R.id.birthdayCard).setOnClickListener { navigateAway(DataTypes.BIRTHDAY) }

        return root
    }

    private fun navigateAway(bundleID: DataTypes) {
        val bundle = Bundle()
        bundle.putString("Id", bundleID.value)
        navController.navigate(R.id.action_navigation_AddData_to_addSpecificData, bundle)
    }
}
