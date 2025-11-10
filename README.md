# Shopping List App (Flutter)

This application is a simple yet functional **shopping list manager** built using **Flutter** and **Dart**. The primary focus of this project was mastering **user input handling**, **list manipulation**, and **connecting to a backend** for persistent data storage. This exercise demonstrates how to create a highly interactive list, manage data models with unique identifiers, and integrate Flutter with a remote database.

---

## ✨ Key Features

* **Item Management:** Users can **add** new items to the list and **delete** them with a simple swipe.
* **Category Tagging:** Every item is assigned a **Category** (e.g., Dairy, Produce, Bakery) for easier sorting and visual grouping.
* **Quantity Tracking:** Allows users to specify the **quantity** of each item they need to purchase.
* **Real-time Synchronization:** Items are saved to and loaded from a **remote database** (e.g., Firebase, using the HTTP package) ensuring the list persists across sessions and devices.
* **Loading and Error Handling:** Demonstrates how to display **loading indicators** and handle **connection errors** when fetching or saving data.
* **Dismissible Items:** Implements the `Dismissible` widget for a modern, fluid user experience when removing items from the list.

---

## 📚 Learning Objectives & Concepts Practiced

This project offers valuable experience with key Flutter/Dart techniques necessary for building data-driven applications that require user interaction and data persistence:

* **User Input Handling and Forms:**
    * **Form Validation:** Implementing checks to ensure users provide valid data (e.g., item name is not empty, quantity is positive).
    * **`TextFormField` and Dropdowns:** Using different form widgets to capture item names, quantities, and categories.

* **Working with Lists and `ListView.builder`:**
    * **Dynamic List Generation:** Creating lists that update instantly based on user input or data fetched from the backend.
    * **Interactive List Items:** Implementing features like the **`Dismissible`** widget to handle item deletion with a swipe gesture.

* **Connecting to a Backend/Database (HTTP Requests):**
    * **Backend Operations:** Performing **C**reate, **R**ead, and **D**elete operations using **HTTP requests** (GET, POST, DELETE).
    * **Asynchronous Programming (`async`/`await`):** Handling network operations gracefully to avoid blocking the user interface.
    * **JSON Data Handling:** Serializing and deserializing data when communicating with a web backend.

* **State Management (`StatefulWidget` & `setState`):**
    * Managing the local state of widgets to handle UI changes, such as loading indicators and user input.
    * Using `setState` to rebuild the UI after asynchronous operations (like fetching data) or user interactions (adding/removing items).
    * This project serves as a foundation for understanding why more advanced state management solutions like Provider or Riverpod become necessary in larger applications.

---

## 📖 Udemy Course Reference

This project was developed as part of the **Flutter & Dart - The Complete Guide [2025 Edition]** course.

**Instructor:** Maximilian Schwarzmüller