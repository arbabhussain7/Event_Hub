# **EventHub 🎉**

EventHub is a comprehensive event management platform designed to connect event enthusiasts with exciting happenings in Islamabad. This app offers robust event discovery, ticket booking, location services, and user management, ensuring a seamless event experience for both attendees and organizers.

## **Features**

### **1. Event Discovery**
* Browse all upcoming events happening in Islamabad.
* Search and filter events by category, date, and location.
* View detailed event information including descriptions, timings, and venue details.

### **2. Ticket Management**
* Purchase event tickets securely through integrated Stripe payment gateway.
* View and manage purchased tickets in a personalized dashboard.
* Receive digital tickets with QR codes for easy event entry.

### **3. Location Services**
* View event locations on an interactive map powered by OpenStreetMap (OSM).
* Get turn-by-turn navigation to event venues.
* Check distance and estimated travel time from your current location.

### **4. User Profile Management**
* Create and customize personal user profiles.
* Track booking history and favorite events.
* Manage account settings and preferences.

## **Technologies Used**

* **Flutter & Dart**: For building a cross-platform mobile application.
* **Firebase**: Backend database for real-time event data and user management.
* **Stripe Payment Gateway**: Secure payment processing for ticket purchases.
* **OpenStreetMap (OSM)**: Integrated mapping services for location features.
* **GetX State Management**: For efficient app logic and state handling.


## **Key Functionalities**

* **Real-time Event Updates**: Events are synchronized in real-time through Firebase integration.
* **Secure Payment Processing**: Stripe ensures safe and reliable payment transactions.
* **Interactive Maps**: Users can explore event locations with detailed mapping features.
* **Profile Customization**: Comprehensive user profile management with booking history.
* **GetX Navigation**: Seamless page routing and navigation management.
* **Reactive Programming**: GetX observables for real-time UI updates.
* **Dependency Injection**: Efficient controller and service management through GetX bindings.

## **Getting Started**

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/eventhub.git
   cd eventhub
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**:
   * Create a Firebase project and add your configuration files.
   * Add `google-services.json` for Android and `GoogleService-Info.plist` for iOS.

4. **Configure Stripe**:
   * Add your Stripe API keys to the environment configuration.
   * Set up webhook endpoints for payment processing.

5. **Run the App**:
   ```bash
   flutter run
   ```

## **Code Structure**

* **lib/controllers/**: Contains GetX controllers for managing app logic and state.
* **lib/models/**: Defines data structures for events, users, and tickets.
* **lib/views/**: Holds all the UI screens and GetView widgets.
* **lib/routes/**: Manages app navigation and route definitions.

## **Configuration**

### **Environment Setup**
Create a `.env` file with the following:
```env
STRIPE_PUBLISHABLE_KEY=your_stripe_publishable_key
STRIPE_SECRET_KEY=your_stripe_secret_key
FIREBASE_API_KEY=your_firebase_api_key
```

### **Firebase Configuration**
* Enable Firestore Database
* Set up Authentication

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Contact

For any questions, feedback, or further information, please contact:

- **Email:** [arbabhussain414@gmail.com](arbabhussain414@gmail.com)
