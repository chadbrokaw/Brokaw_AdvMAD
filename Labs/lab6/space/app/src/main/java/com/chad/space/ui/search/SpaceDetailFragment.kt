package com.chad.space.ui.search

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.chad.space.R
import com.google.android.material.bottomnavigation.BottomNavigationView
import com.bumptech.glide.Glide

class SpaceDetailFragment : Fragment() {

    private lateinit var sharedSearchViewModel: SharedSearchViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        activity?.findViewById<BottomNavigationView>(R.id.nav_view)?.visibility = android.view.View.GONE

        val root = inflater.inflate(R.layout.fragment_space_detail,container, false)

        val spaceTitleTextView = root.findViewById<TextView>(R.id.spaceTitleTextView)
        val explanationTextView = root.findViewById<TextView>(R.id.explanationTextView)
        val imageView = root.findViewById<ImageView>(R.id.spaceImageView)

        sharedSearchViewModel = ViewModelProvider(requireActivity()).get(SharedSearchViewModel::class.java)
        sharedSearchViewModel.selectedSpace.observe(viewLifecycleOwner, Observer {
            Log.i("spaceLogging", "Selected explanation: ${it.explanation}")

            explanationTextView.text = it.explanation
        })

        sharedSearchViewModel.spaceDetails.observe(viewLifecycleOwner, Observer {
            Log.i("spaceLogging", "Selected space title: ${it.title}")

            (activity as AppCompatActivity?)?.supportActionBar?.title = it.title

            spaceTitleTextView.text = it.title

            Glide.with(this)
                .load(it.url)
                .into(imageView)
        })

        return root
    }

}
