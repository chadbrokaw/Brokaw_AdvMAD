package com.chad.mtracker.ui.addData

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.cardview.widget.CardView
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import com.chad.mtracker.R

class AddDataFragment : Fragment() {

//    private lateinit var addDataViewModel: AddSpecificDataViewModel

    override fun onCreateView(
            inflater: LayoutInflater,
            container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
//        addDataViewModel =
//                ViewModelProvider(this).get(AddSpecificDataViewModel::class.java)
        val root = inflater.inflate(R.layout.fragment_add_data, container, false)
        val weightCard: CardView = root.findViewById(R.id.weightCard)
        weightCard.setOnClickListener{ Log.e("TEST", "Chad") }
//        val textView: TextView = root.findViewById(R.id.text_add_data)
//        addDataViewModel.text.observe(viewLifecycleOwner, Observer {
//            textView.text = it
//        })
        return root
    }
}
