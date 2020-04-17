package com.chad.space.ui.search

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.chad.space.data.Space
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.NavController
import androidx.navigation.Navigation
import androidx.recyclerview.widget.RecyclerView
import com.chad.space.R

class SearchFragment : Fragment(), SearchRecyclerAdapter.SpaceItemListener {

    private lateinit var sharedSearchViewModel: SharedSearchViewModel
    private lateinit var recyclerView: RecyclerView
    private lateinit var navController: NavController

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        navController = Navigation.findNavController(requireActivity(), R.id.nav_host_fragment)

        sharedSearchViewModel = ViewModelProvider(requireActivity()).get(SharedSearchViewModel::class.java)

        val root = inflater.inflate(R.layout.fragment_search, container, false)

        recyclerView = root.findViewById(R.id.recyclerView)

        sharedSearchViewModel.spaceData.observe(viewLifecycleOwner, Observer {
            val adapter = SearchRecyclerAdapter(requireContext(), it, this)
            recyclerView.adapter = adapter
        })

        return root
    }

    override fun onSpaceItemClick(space: Space) {
        Log.i("spaceLogging", space.toString())
        sharedSearchViewModel.selectedSpace.value = space
        navController.navigate(R.id.action_navigation_search_to_spaceDetailFragment)
    }
}
