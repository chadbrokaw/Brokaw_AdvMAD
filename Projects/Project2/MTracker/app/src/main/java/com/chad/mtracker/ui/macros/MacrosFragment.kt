package com.chad.mtracker.ui.macros

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import com.chad.mtracker.MainActivity
import com.chad.mtracker.R
import com.chad.mtracker.data.MacroData
import com.chad.mtracker.data.NutritionData
import com.google.firebase.firestore.FieldValue
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.firestore.ktx.toObject
import com.google.firebase.ktx.Firebase

class MacrosFragment : Fragment() {

    private lateinit var macrosViewModel: MacrosViewModel
    private lateinit var nutritionData: NutritionData
    private lateinit var macroData: MacroData
    private lateinit var root: View

    override fun onCreateView(
            inflater: LayoutInflater,
            container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        macrosViewModel = ViewModelProvider(this).get(MacrosViewModel::class.java)
        root = inflater.inflate(R.layout.fragment_macros, container, false)

        root.findViewById<Button>(R.id.refreshButton).setOnClickListener { getData() }
        getDataInitially()

        return root
    }

    private fun setStartState() {
        root.findViewById<TextView>(R.id.proteinText).text = "Add Data"
        root.findViewById<TextView>(R.id.fatText).text = "Add Data"
        root.findViewById<TextView>(R.id.carbText).text = "Add Data"
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

    private fun determineWhatToDo() {
        if(nutritionData.macro_carb == -1 || nutritionData.macro_fat == -1 || nutritionData.macro_protein == -1) {
            setStartState()
        }
        else {
            macroData = MacroData(nutritionData.macro_protein ?: -404, nutritionData.macro_fat ?: -404, nutritionData.macro_carb ?: -404)
            setData()
        }
    }

    private fun getDataInitially() {
        setLoadingData()

        val db = Firebase.firestore

        db.collection("dataTracking")
            .document("RPoNiZKWDRvm9tQZ69tW")
            .get()
            .addOnSuccessListener { document ->
                val tempNutritionData = document.toObject<NutritionData>()

                if (tempNutritionData != null) {
                    nutritionData = tempNutritionData
                    determineWhatToDo()
                }
            }
            .addOnFailureListener { exception ->
                Log.w("MTracker", "Error getting documents.", exception)
            }
    }

    private fun getData() {
        setLoadingData()

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
    }

    private fun writeData() {
        val db = Firebase.firestore

        val data = hashMapOf<String, Any>(
            "macro_protein" to macroData.protein,
            "macro_fat" to macroData.fat,
            "macro_carb" to macroData.carbs
        )

        db.collection("dataTracking").document("RPoNiZKWDRvm9tQZ69tW")
            .update(data)
            .addOnSuccessListener { Log.d("Mtracker", "DocumentSnapshot successfully updated!") }
            .addOnFailureListener { e -> Log.e("Mtracker", "Error updating document", e) }
    }

    private fun calculateData() {
        val kgWeight = getWeight()
        val cmHeight = getHeight()
        val bodyFatPercentage = getBFP()
        val age = getAge()
        val activityLevel = getActivityLevel()

        if (kgWeight == -9.0 || cmHeight == -9.0 || bodyFatPercentage == -9.0 || age == -9.0 || activityLevel == -9.0) {
            setStartState()
            return
        }

        val BMR_KatchMcArdle = calculateBMRKatchMcArdle(bodyFatPercentage, kgWeight)
        val BMR_MifflinStJeor = calculateBMRMifflinStJeor(kgWeight, cmHeight, age)

        val BMR_Avg = (BMR_KatchMcArdle + BMR_MifflinStJeor) / 2
        val TDEE_Grams = BMR_Avg * activityLevel

        macroData = MacroData((TDEE_Grams * 0.4).toInt(), (TDEE_Grams * 0.3).toInt(), (TDEE_Grams * 0.4).toInt())

        writeData()

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

        val mostRecentActivityLevel = activityLevelArray[activityLevelArrayLength - 1].toDouble() / 10

        return 1 + mostRecentActivityLevel
    }
}
