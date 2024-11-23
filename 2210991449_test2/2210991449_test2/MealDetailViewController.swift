//
//  MealDetailViewController.swift
//  2210991449_test2
//
//  Created by student-2 on 23/11/24.
//

import UIKit

class MealDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var recipeNameTextField: UITextField!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var preparationInstructionsTextView: UITextView!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var nutritionalInformationTextField: UITextField!
    @IBOutlet weak var preparationTimeTextField: UITextField!
    @IBOutlet weak var thumbnailImageView: UIImageView!

    var meal: Meal?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let meal = meal { print("Meal data received: \(meal)")
            recipeNameTextField.text = meal.recipeName
            ingredientsTextView.text = meal.ingredients
            preparationInstructionsTextView.text = meal.preparationInstructions
            categoryTextField.text = meal.category
            nutritionalInformationTextField.text = "\(meal.nutritionalInformation)"
            preparationTimeTextField.text = meal.preparationTime
            if let thumbnailData = meal.thumbnail {
                thumbnailImageView.image = UIImage(data: thumbnailData)
            }
        } else {
            print("No meal data received")
        }
    }

    @IBAction func selectImage(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            thumbnailImageView.image = image
            meal?.thumbnail = image.jpegData(compressionQuality: 1.0)
        }
        dismiss(animated: true, completion: nil)
    }

    @IBAction func saveMeal(_ sender: UIBarButtonItem) {
        print("Save button pressed")  // Debug print statement
        guard let recipeName = recipeNameTextField.text, !recipeName.isEmpty,
              let ingredients = ingredientsTextView.text, !ingredients.isEmpty,
              let preparationInstructions = preparationInstructionsTextView.text, !preparationInstructions.isEmpty,
              let category = categoryTextField.text, !category.isEmpty,
              let nutritionalInfoText = nutritionalInformationTextField.text, let nutritionalInformation = Int(nutritionalInfoText),
              let preparationTime = preparationTimeTextField.text, !preparationTime.isEmpty else {
            return
        }

        if meal == nil {
            meal = Meal(recipeName: recipeName, ingredients: ingredients, preparationInstructions: preparationInstructions, category: category, nutritionalInformation: nutritionalInformation, preparationTime: preparationTime, thumbnail: thumbnailImageView.image?.jpegData(compressionQuality: 1.0))
        } else {
            meal?.recipeName = recipeName
            meal?.ingredients = ingredients
            meal?.preparationInstructions = preparationInstructions
            meal?.category = category
            meal?.nutritionalInformation = nutritionalInformation
            meal?.preparationTime = preparationTime
        }

        saveMeals()
        navigationController?.popViewController(animated: true)
    }


    func saveMeals() {
        guard let mealsVC = navigationController?.viewControllers.first as? MealListTableViewController else { return }
        if let index = mealsVC.meals.firstIndex(where: { $0.recipeName == meal?.recipeName }) {
            mealsVC.meals[index] = meal!
        } else {
            mealsVC.meals.append(meal!)
        }
        let encoder = JSONEncoder()
        if let encodedMeals = try? encoder.encode(mealsVC.meals) {
            UserDefaults.standard.set(encodedMeals, forKey: "meals")
        }
        mealsVC.tableView.reloadData()
    }


    @IBAction func shareRecipe(_ sender: UIBarButtonItem) {
        let recipeDetails = """
        Recipe Name: \(recipeNameTextField.text ?? "")
        Ingredients: \(ingredientsTextView.text ?? "")
        Preparation Instructions: \(preparationInstructionsTextView.text ?? "")
        Category: \(categoryTextField.text ?? "")
        Nutritional Information: \(nutritionalInformationTextField.text ?? "")
        Preparation Time: \(preparationTimeTextField.text ?? "")
        """
        let activityController = UIActivityViewController(activityItems: [recipeDetails, thumbnailImageView.image as Any], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
}


