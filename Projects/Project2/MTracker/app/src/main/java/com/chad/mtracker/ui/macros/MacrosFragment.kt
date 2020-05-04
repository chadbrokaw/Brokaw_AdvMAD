package com.chad.mtracker.ui.macros

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import com.chad.mtracker.R
import com.chad.mtracker.data.MacroData
import com.chad.mtracker.data.NutritionData
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.firestore.ktx.toObject
import com.google.firebase.ktx.Firebase

class MacrosFragment : Fragment() {

    private lateinit var macrosViewModel: MacrosViewModel
    private lateinit var nutritionData: NutritionData
    private lateinit var macroData: MacroData
    private var loading: Boolean = false
    private lateinit var root: View

    override fun onCreateView(
            inflater: LayoutInflater,
            container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        macrosViewModel = ViewModelProvider(this).get(MacrosViewModel::class.java)
        root = inflater.inflate(R.layout.fragment_macros, container, false)

        setLoadingData()

        getData()

        return root
    }

    private fun setLoadingData() {
        root.findViewById<TextView>(R.id.proteinText).text = "Loading..."
        root.findViewById<TextView>(R.id.fatText).text = "Loading..."
        root.findViewById<TextView>(R.id.carbText).text = "Loading..."
    }

    private fun setData() {
        root.findViewById<TextView>(R.id.proteinText).text = "${macroData.protein.toInt()}g"
        root.findViewById<TextView>(R.id.fatText).text = "${macroData.fat.toInt()}g"
        root.findViewById<TextView>(R.id.carbText).text = "${macroData.carbs.toInt()}g"
    }

    private fun getData() {
        loading = true
        val db = Firebase.firestore

        db.collection("dataTracking")
            .document("RPoNiZKWDRvm9tQZ69tW")
            .get()
            .addOnSuccessListener { document ->
                val tempNutritionData = document.toObject<NutritionData>()

                if (tempNutritionData != null) {
                    nutritionData = tempNutritionData
                    calculateData()
                }
            }
            .addOnFailureListener { exception ->
                Log.w("MTracker", "Error getting documents.", exception)
            }
        loading = false
    }

    private fun calculateData() {
        val kgWeight = getWeight()
        val cmHeight = getHeight()
        val bodyFatPercentage = getBFP()
        val age = getAge()
        val activityLevel = getActivityLevel()

        val BMR_KatchMcArdle = calculateBMRKatchMcArdle(bodyFatPercentage, kgWeight)
        val BMR_MifflinStJeor = calculateBMRMifflinStJeor(kgWeight, cmHeight, age)

        val TDEE_Grams = (BMR_KatchMcArdle + BMR_MifflinStJeor) / 2

        macroData = MacroData(TDEE_Grams * 0.4, TDEE_Grams * 0.3, TDEE_Grams * 0.4)

        setData()
    }

    private fun calculateBMRMifflinStJeor(kgWeight: Double, cmHeight: Double, age: Double): Double {
        return (10 * kgWeight) + (6.25 * cmHeight) - (5 * age) + 5
    }

    private fun calculateBMRKatchMcArdle(BFP: Double, kgWeight: Double) : Double {
        val leanBodyMass = (kgWeight * (100 - BFP)) / 100

        return 370 + (21.6 * leanBodyMass)
    }

    private fun getWeight(): Double {
        val weightArray = nutritionData.weight ?: return -9.0
        val weightArrayLength = weightArray.size

        if (weightArrayLength == 0) {
            return -9.0
        }

        val mostRecentWeight = weightArray[weightArrayLength - 1].toDouble()

        return mostRecentWeight / 2.205
    }

    private fun getHeight(): Double {
        val heightArray = nutritionData.height ?: return -9.0
        val heightArrayLength = heightArray.size

        if (heightArrayLength == 0) {
            return -9.0
        }

        val mostRecentHeight = heightArray[heightArrayLength - 1].toDouble()

        return mostRecentHeight * 2.54
    }

    private fun getBFP(): Double {
        val bfpArray = nutritionData.body_fat_percentage ?: return -9.0
        val bfpArrayLength = bfpArray.size

        if (bfpArrayLength == 0) {
            return -9.0
        }

        return bfpArray[bfpArrayLength - 1].toDouble()
    }

    private fun getAge(): Double {
        val ageArray = nutritionData.birthday ?: return -9.0
        val ageArrayLength = ageArray.size

        if (ageArrayLength == 0) {
            return -9.0
        }

        return ageArray[ageArrayLength - 1].toDouble()
    }

    private fun getActivityLevel(): Double {
        val activityLevelArray = nutritionData.activity_level ?: return -9.0
        val activityLevelArrayLength = activityLevelArray.size

        if (activityLevelArrayLength == 0) {
            return -9.0
        }

        return activityLevelArray[activityLevelArrayLength - 1].toDouble()
    }
}
