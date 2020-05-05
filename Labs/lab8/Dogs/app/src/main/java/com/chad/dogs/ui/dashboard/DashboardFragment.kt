package com.chad.dogs.ui.dashboard

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import com.chad.dogs.R
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.firestore.ktx.toObject
import com.google.firebase.ktx.Firebase

class DashboardFragment : Fragment() {

    private lateinit var dashboardViewModel: DashboardViewModel
    private lateinit var dogData: DogData
    private lateinit var root: View

    private var noData = true

    override fun onCreateView(
            inflater: LayoutInflater,
            container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        dashboardViewModel =
                ViewModelProviders.of(this).get(DashboardViewModel::class.java)
        root = inflater.inflate(R.layout.fragment_dashboard, container, false)

        root.findViewById<Button>(R.id.DeleteFavorite).setOnClickListener { delete() }

        getData()

        return root
    }

    private fun delete() {
        if (noData) {
            return
        }
        else {
            val db = Firebase.firestore

            val data = hashMapOf<String, Any>(
                "DogType" to "",
                "Fluffiness" to -1
            )

            db.collection("dogs").document("9Ji96sWTfs2GAwnNBb0Z").update(data)
                .addOnSuccessListener { Log.d("DOGS", "DocumentSnapshot successfully updated!") }
                .addOnFailureListener { e -> Log.e("DOGS", "Error updating document", e) }

            setNoData()
        }
    }

    private fun getData() {
        setLoading()

        val db = Firebase.firestore

        db.collection("dogs").document("9Ji96sWTfs2GAwnNBb0Z")
            .get()
            .addOnSuccessListener { document ->
                val tempDogData = document.toObject<DogData>()

                if (tempDogData != null) {
                    dogData = tempDogData
                    setData()
                }
            }
            .addOnFailureListener { exception ->
                Log.w("Dogs", "Error getting documents.", exception)
            }
    }

    private fun setLoading() {
        root.findViewById<TextView>(R.id.favDogFluffiness).text = "Loading..."
        root.findViewById<TextView>(R.id.favDogType).text = "Loading..."
    }

    private fun setData() {

        val FavDogType = dogData.DogType ?: ""
        val FavDogFluffiness = dogData.Fluffiness ?: -1

        if (FavDogType.length == 0|| FavDogFluffiness == -1) {
            setNoData()
            return
        }
        root.findViewById<TextView>(R.id.favDogFluffiness).text = "Favorite Dog Fluffiness: ${FavDogFluffiness}"
        root.findViewById<TextView>(R.id.favDogType).text = "Favorite Dog Type: ${FavDogType}"
        noData = false

    }

    private fun setNoData() {
        root.findViewById<TextView>(R.id.favDogFluffiness).text = "No Dog Entered"
        root.findViewById<TextView>(R.id.favDogType).text = "No Dog Entered"
        noData = true
        return
    }
}
