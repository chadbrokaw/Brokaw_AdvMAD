package com.chad.dogs.ui.addData

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.EditText
import androidx.fragment.app.Fragment
import com.chad.dogs.R
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase

class AddDataFragment : Fragment() {


    private lateinit var root: View

    override fun onCreateView(
            inflater: LayoutInflater,
            container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        root = inflater.inflate(R.layout.fragment_add_data, container, false)

        root.findViewById<Button>(R.id.saveButton).setOnClickListener { sendData() }

        return root
    }

    private fun sendData() {
        val fluffiness = root.findViewById<EditText>(R.id.dogFluffiness).text.toString()
        val dogType = root.findViewById<EditText>(R.id.DogType).text.toString()

        if (fluffiness.isEmpty() || dogType.isEmpty() ) {
            return
        }

        val db = Firebase.firestore

        val data = hashMapOf<String, Any>(
            "DogType" to dogType,
            "Fluffiness" to fluffiness.toInt()
        )

        db.collection("dogs").document("9Ji96sWTfs2GAwnNBb0Z").update(data)
            .addOnSuccessListener { Log.d("DOGS", "DocumentSnapshot successfully updated!") }
            .addOnFailureListener { e -> Log.e("DOGS", "Error updating document", e) }
    }
}
