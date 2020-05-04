package com.chad.mtracker.data

data class DataTypeInformation (
    val title: String,
    val inputType: String,
    val specialInstructions: String,
    val firestoreID: String
)

class DataManager {
    fun getDataCustomizations(dataTypes: String?): DataTypeInformation {
        return when(dataTypes) {
            DataTypes.WEIGHT.value -> DataTypeInformation(
                title = "Weight",
                inputType = "number",
                specialInstructions = "Please enter your weight in whole pounds",
                firestoreID = "weight"
            )
            DataTypes.HEIGHT.value -> DataTypeInformation(
                title = "Height",
                inputType = "number",
                specialInstructions = "Please enter your height in inches",
                firestoreID = "height"
            )
            DataTypes.ACTIVITY_LEVEL.value -> DataTypeInformation(
                title = "Activity Level",
                inputType = "number",
                specialInstructions = "Please enter your activity as a value between 1 and 2",
                firestoreID = "activity_level"
            )
            DataTypes.BODY_FAT_PERCENTAGE.value -> DataTypeInformation(
                title = "Body Fat Percentage",
                inputType = "number",
                specialInstructions = "Please enter your body fat percentage out of 100",
                firestoreID = "body_fat_percentage"
            )
            DataTypes.WAIST_SIZE.value -> DataTypeInformation(
                title = "Waist Size",
                inputType = "number",
                specialInstructions = "Please enter your waist size in inches",
                firestoreID = "waist_size"
            )
            DataTypes.CHEST_SIZE.value -> DataTypeInformation(
                title = "Chest Size",
                inputType = "number",
                specialInstructions = "Please enter your chest size in inches",
                firestoreID = "chest_size"
            )
            DataTypes.BIRTHDAY.value -> DataTypeInformation(
                title = "Birthday",
                inputType = "number",
                specialInstructions = "Please enter your age as a whole number",
                firestoreID = "birthday"
            )
            else -> DataTypeInformation(
                title = "Unknown",
                inputType = "number",
                specialInstructions = "Yikes",
                firestoreID = "big_yikes"
            )
        }
    }
}