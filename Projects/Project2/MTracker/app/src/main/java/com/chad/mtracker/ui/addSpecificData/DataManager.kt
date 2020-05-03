package com.chad.mtracker.ui.addSpecificData

data class DataTypeInformation (
    val title: String,
    val inputType: String,
    val specialInstructions: String
)

class DataManager {
    fun getDataCustomizations(dataTypes: String?): DataTypeInformation {
        return when(dataTypes) {
            DataTypes.WEIGHT.value -> DataTypeInformation(title = "Weight", inputType = "number", specialInstructions = "Please enter your weight in whole pounds" )
            DataTypes.HEIGHT.value -> DataTypeInformation(title = "Height", inputType = "number", specialInstructions = "Please enter your height in inches" )
            DataTypes.ACTIVITY_LEVEL.value -> DataTypeInformation(title = "Activity Level", inputType = "number", specialInstructions = "Please enter your activity as a decimal between 1 and 2" )
            DataTypes.BODY_FAT_PERCENTAGE.value -> DataTypeInformation(title = "Body Fat Percentage", inputType = "number", specialInstructions = "Please enter your body fat percentage out of 100" )
            DataTypes.WAIST_SIZE.value -> DataTypeInformation(title = "Waist Size", inputType = "number", specialInstructions = "Please enter your waist size in inches" )
            DataTypes.CHEST_SIZE.value -> DataTypeInformation(title = "Chest Size", inputType = "number", specialInstructions = "Please enter your chest size in inches" )
            DataTypes.BIRTHDAY.value -> DataTypeInformation(title = "Birthday", inputType = "number", specialInstructions = "Please enter your age as a whole number" )
            else -> DataTypeInformation(title = "Unknown", inputType = "number", specialInstructions = "Yikes" )
        }
    }
}