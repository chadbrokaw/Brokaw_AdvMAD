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
import com.chad.mtracker.data.NutritionData
import com.google.firebase.firestore.FieldValue
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.firestore.ktx.toObject
import com.google.firebase.ktx.Firebase

/**
 * A simple [Fragment] subclass.
 */
class AddSpecificData : Fragment() {

    private lateinit var root: View
    private lateinit var nutritionData: NutritionData

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

        getData(dataCustomizations.firestoreID)

        root.findViewById<Button>(R.id.saveButton).setOnClickListener { setData(dataCustomizations.firestoreID) }

        return root
    }

    private fun getData(firestorID: String) {
        val db = Firebase.firestore

        db.collection("dataTracking")
            .document("RPoNiZKWDRvm9tQZ69tW")
            .get()
            .addOnSuccessListener { document ->
                val tempNutritionData = document.toObject<NutritionData>()

                if (tempNutritionData != null) {
                    nutritionData = tempNutritionData
                    determineCurrentToSet(firestorID)
                }
            }
            .addOnFailureListener { exception ->
                Log.w("MTracker", "Error getting documents.", exception)
            }
    }

    private fun determineCurrentToSet(firestorID: String) {
        when (firestorID) {
            "weight" -> setCurrent(nutritionData.weight)
            "height" -> setCurrent(nutritionData.height)
            "activity_level" -> setCurrent(nutritionData.activity_level)
            "body_fat_percentage" -> setCurrent(nutritionData.body_fat_percentage)
            "waist_size" -> setCurrent(nutritionData.waist_size)
            "chest_size" -> setCurrent(nutritionData.chest_size)
            "birthday" -> setCurrent(nutritionData.birthday)
            else -> Log.e("MTracker", "Cannot determine current with ${firestorID}")
        }
    }

    private fun setCurrent(arr: List<Long>?) {
        if (arr == null) {
            return
        }
        if (arr.isEmpty()) {
            root.findViewById<TextView>(R.id.currentEntry).text = "No current value set"
            return
        }

        val arrSize = arr.size

        root.findViewById<TextView>(R.id.currentEntry).text = "Current Value: ${arr[arrSize - 1]}"
    }

    private fun setData(dataID: String) {


        val value = root.findViewById<EditText>(R.id.dataEntry).text.toString().toDouble()

        val db = Firebase.firestore

        db.collection("dataTracking").document("RPoNiZKWDRvm9tQZ69tW")
            .update(dataID, FieldValue.arrayUnion(value))
            .addOnSuccessListener { Log.d("Mtracker", "DocumentSnapshot successfully updated!") }
            .addOnFailureListener { e -> Log.e("Mtracker", "Error updating document", e) }

        if (dataID == "activity_level") {
            root.findViewById<TextView>(R.id.currentEntry).text = "Current Value: ${value}"
        }
        else {
            root.findViewById<TextView>(R.id.currentEntry).text = "Current Value: ${value.toInt()}"
        }


    }
}
