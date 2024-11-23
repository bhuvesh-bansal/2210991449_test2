//
//  Meal.swift
//  2210991449_test2
//
//  Created by student-2 on 23/11/24.
//

import Foundation

struct Meal: Codable {
    var recipeName: String
    var ingredients: String
    var preparationInstructions: String
    var category: String
    var nutritionalInformation: Int
    var preparationTime: String
    var thumbnail: Data?
}

func getExampleMeals() -> [Meal] {
    return [
        Meal(recipeName: "Butter Chicken", ingredients: "Chicken, Butter, Tomatoes, Cream, Spices", preparationInstructions: "Cook chicken with spices. Add butter, tomatoes, and cream. Simmer until thickened.", category: "Non-Vegetarian", nutritionalInformation: 400, preparationTime: "45 mins", thumbnail: nil),
        Meal(recipeName: "Chole Bhature", ingredients: "Chickpeas, Flour, Yogurt, Spices", preparationInstructions: "Cook chickpeas with spices. Prepare dough for bhature. Deep fry bhature and serve with chole.", category: "Vegetarian", nutritionalInformation: 500, preparationTime: "60 mins", thumbnail: nil),
        Meal(recipeName: "Paneer Tikka", ingredients: "Paneer, Yogurt, Spices", preparationInstructions: "Marinate paneer in yogurt and spices. Grill or bake until golden brown.", category: "Vegetarian", nutritionalInformation: 300, preparationTime: "30 mins", thumbnail: nil)
    ]
}

let meal: [Meal] = [
    Meal(
        recipeName: "Butter Chicken",
        ingredients: "Chicken, Butter, Tomatoes, Cream, Spices",
        preparationInstructions: "Cook chicken with spices. Add butter, tomatoes, and cream. Simmer until thickened.",
        category: "Non-Vegetarian",
        nutritionalInformation: 400,
        preparationTime: "45 mins",
        thumbnail: nil
    ),
    Meal(
        recipeName: "Chole Bhature",
        ingredients: "Chickpeas, Flour, Yogurt, Spices",
        preparationInstructions: "Cook chickpeas with spices. Prepare dough for bhature. Deep fry bhature and serve with chole.",
        category: "Vegetarian",
        nutritionalInformation: 500,
        preparationTime: "60 mins",
        thumbnail: nil
    ),
    Meal(
        recipeName: "Paneer Tikka",
        ingredients: "Paneer, Yogurt, Spices",
        preparationInstructions: "Marinate paneer in yogurt and spices. Grill or bake until golden brown.",
        category: "Vegetarian",
        nutritionalInformation: 300,
        preparationTime: "30 mins",
        thumbnail: nil
    )
]


