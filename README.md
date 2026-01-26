# MediaTracker

MediaTracker is a simple educational iOS application built using the SwiftUI and SwiftData frameworks. This project serves as a learning tool for database management, form handling, and list manipulation in the Swift programming environment.

🎯 Project Purpose
This is an educational project created to practice:

Implementing a data model using the @Model macro in SwiftData.

Building user interfaces with SwiftUI, including Forms, Lists, and Sheets.

Performing CRUD (Create, Read, Update, Delete) operations on a local database.

🚀 Features
The application allows users to manage a collection of movies and TV shows:

Add New Items: Users can enter a title, director, and select the type (Film or Serial).

Status Tracking: Ability to toggle whether a title has been watched.

Rating System: If an item is marked as watched, the user can assign a rating from 1 to 5 stars using a Stepper.

Favorites: Users can quickly mark items as favorites directly from the main list using a star icon.

Edit Data: Tapping an item opens an edit sheet (EditMediaView) to update information.

Deletion: Supports the "swipe-to-delete" gesture to permanently remove records from the database.

🛠️ Technology Stack
Language: Swift

UI Framework: SwiftUI

Database: SwiftData (a modern replacement for Core Data using native macros)

📂 File Structure
Item.swift: Contains the Media model definition with properties for name, director, type, watch status, rating, and creation date.

ContentView.swift: The main view containing the entry form, the media list, and deletion logic.

EditMediaView (within ContentView.swift): A sheet-based view for modifying existing entries.

MediaTrackerApp.swift: The application entry point where the modelContainer is configured for the Media model.

📱 How to Run
Open the project in Xcode.

Select an iPhone simulator or connect a physical device.

Run the project (Command + R).

Data is automatically persisted thanks to the SwiftData integration in the app's model container.
