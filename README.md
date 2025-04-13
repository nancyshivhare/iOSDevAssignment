# iOS Developer Assignment

## Objective:
This iOS application includes user authentication, offline data management, push notifications, image handling, and a PDF viewer.

## Features:
1. **User Authentication**:
   - Implements **Google Sign-In** using **Firebase Authentication**.
   - Saves user details in **Core Data**.

2. **PDF Viewer**:
   - Displays the **BalanceSheet.pdf** from the provided URL: [PDF Viewer](https://fssservices.bookxpert.co/GeneratedPDF/Companies/nadc/2024-2025/BalanceSheet.pdf).
   - Uses a third-party library to show the PDF within the app.

3. **Image Capture & Gallery Selection**:
   - Allows users to **capture an image** using the camera.
   - Allows users to **select an image** from the gallery.
   - Displays the selected image in the app.

4. **Core Data Implementation**:
   - Fetches data from the API: [API Endpoint](https://api.restful-api.dev/objects).
   - Saves the fetched data into **Core Data**.
   - Provides functionality to **Update** and **Delete** items in the saved data.
   - Error handling and validation for API data.

5. **Push Notification**:
   - Sends **real-time notifications** when an item is deleted.
   - Notification includes item details such as name and capacity.
   - Allows users to enable/disable notifications.

6. **Other Features**:
   - **Dark and Light Theme**: Handles theme switching and persistence across app restarts.
   - **Camera & Storage Permissions**: Manages runtime permissions for camera and storage.

## Technical Requirements:
- **Language**: Swift
- **Architecture**: MVVM (Model-View-ViewModel)
- **Libraries**: Firebase, PDFKit, Alamofire (if used for API calls), CoreData
- **UI/UX**: Modern, clean, and responsive design with a focus on user experience.

## Setup Instructions:

1. Clone the repository:
   ```bash
   git clone https://github.com/<your-username>/<repo-name>.git
Install dependencies: If you’re using CocoaPods:

bash
Copy
Edit
pod install
If you're using Swift Package Manager (SPM), ensure the packages are integrated into your Xcode project.

Firebase Setup:

Set up Firebase for your project and get the GoogleService-Info.plist file.

Follow the Firebase iOS setup guide to integrate Firebase into your Xcode project.

Ensure that Google Sign-In is enabled in your Firebase console.

Run the App:

Open the .xcworkspace file and run the app on your simulator or physical device.
