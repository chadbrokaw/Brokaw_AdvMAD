package com.chad.mtracker.ui.addSpecificData

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import com.chad.mtracker.R
import com.google.firebase.firestore.FieldValue
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase

/**
 * A simple [Fragment] subclass.
 */
class AddSpecificData : Fragment() {

    private lateinit var root: View

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment

        val id = arguments?.getString("Id", "unknown")

        val dataManager = DataManager()
        val dataCustomizations = dataManager.getDataCustomizations(id)

        root = inflater.inflate(R.layout.fragment_add_specific_data, container, false)
        root.findViewById<TextView>(R.id.dataTypeTitle).text = dataCustomizations.title
        root.findViewById<TextView>(R.id.hintText).text = dataCustomizations.specialInstructions

        root.findViewById<Button>(R.id.saveButton).setOnClickListener { setData(dataCustomizations.firestoreID) }

        return root
    }

    private fun setData(dataID: String) {


        val value = root.findViewById<EditText>(R.id.dataEntry).text.toString().toInt()

        val db = Firebase.firestore

        db.collection("dataTracking").document("RPoNiZKWDRvm9tQZ69tW")
            .update(dataID, FieldValue.arrayUnion(value))
            .addOnSuccessListener { Log.d("Mtracker", "DocumentSnapshot successfully updated!") }
            .addOnFailureListener { e -> Log.e("Mtracker", "Error updating document", e) }
    }
}
