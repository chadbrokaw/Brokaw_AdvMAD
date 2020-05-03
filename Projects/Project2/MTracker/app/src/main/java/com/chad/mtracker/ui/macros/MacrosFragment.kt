package com.chad.mtracker.ui.macros

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.chad.mtracker.R
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase

class MacrosFragment : Fragment() {

    private lateinit var macrosViewModel: MacrosViewModel

    override fun onCreateView(
            inflater: LayoutInflater,
            container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        macrosViewModel = ViewModelProvider(this).get(MacrosViewModel::class.java)
        val root = inflater.inflate(R.layout.fragment_macros, container, false)
        val db = Firebase.firestore

//        db.collection("dataTracking")
//            .document("RPoNiZKWDRvm9tQZ69tW")
//            .get()
//            .addOnSuccessListener { document ->
//                    Log.d("MTracker", "${document.data?}")
//            }
//            .addOnFailureListener { exception ->
//                Log.w("MTracker", "Error getting documents.", exception)
//            }
//        val textView: TextView = root.findViewById(R.id.text_macros)
//        macrosViewModel.text.observe(viewLifecycleOwner, Observer {
//            textView.text = it
//        })
        return root
    }
}
