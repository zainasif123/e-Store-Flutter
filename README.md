<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>e-Store App</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        h1, h2, h3 {
            color: #007bff;
        }
        a {
            color: #007bff;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .large-image {
            width: 100%;
            height: auto;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .demo-image {
            width: 100%;
            height: auto;
            border-radius: 8px;
        }
        code {
            background: #f4f4f4;
            padding: 2px 6px;
            border-radius: 4px;
            font-size: 0.9em;
        }
        pre {
            background: #f4f4f4;
            padding: 10px;
            border-radius: 4px;
            overflow-x: auto;
        }
        .hashtag {
            display: inline-block;
            padding: 4px 8px;
            margin: 2px;
            background: #007bff;
            color: #fff;
            border-radius: 4px;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div class="container">
        <img src="images/demo.png" alt="e-Store App Demo" class="large-image">

        <h1>e-Store App</h1>

        <h2>Overview</h2>
        <p>Welcome to the e-Store App project! This application is designed to streamline the selling of computer accessories for a local electronics shop. It provides a comprehensive solution with distinct interfaces for both clients and administrators, ensuring a seamless and efficient experience for all users.</p>
        
        <h2>Key Features</h2>

        <h3>Client Side</h3>
        <ul>
            <li><strong>User-Friendly Interface:</strong> Customers can easily browse, view, and purchase products with an intuitive and visually appealing UI.</li>
            <li><strong>Real-Time Updates:</strong> Secure and efficient user authentication and real-time updates with Firebase.</li>
        </ul>

        <h3>Admin Side</h3>
        <ul>
            <li><strong>Product Management:</strong> Administrators can efficiently manage products, update details, and handle inventory.</li>
            <li><strong>Order Management:</strong> Track and manage customer orders with ease.</li>
            <li><strong>User Data Management:</strong> Access and manage user data for better service and insights.</li>
        </ul>

        <h3>State Management</h3>
        <p><strong>Modern Techniques:</strong> Utilizes advanced state management techniques to ensure smooth and responsive interactions throughout the app.</p>

        <h3>User Interface Design</h3>
        <p><strong>Clean & Intuitive:</strong> Designed with a focus on usability and visual appeal to enhance the overall user experience.</p>

        <h3>Technical Highlights</h3>
        <ul>
            <li><strong>Flutter:</strong> Developed using Flutter for a robust and cross-platform solution.</li>
            <li><strong>Firebase:</strong> Integrated for real-time database management and authentication, ensuring up-to-date data synchronization.</li>
            <li><strong>Stripe:</strong> Seamless payment processing with Stripe, offering secure and versatile payment options.</li>
            <li><strong>State Management:</strong> Implemented state management techniques to maintain a responsive and efficient application.</li>
        </ul>

        <h2>Installation</h2>
        <ol>
            <li><strong>Clone the repository</strong>
                <pre><code>git clone https://github.com/your-username/e-store-app.git</code></pre>
            </li>
            <li><strong>Navigate to the project directory</strong>
                <pre><code>cd e-store-app</code></pre>
            </li>
            <li><strong>Install dependencies</strong>
                <pre><code>flutter pub get</code></pre>
            </li>
            <li><strong>Run the app</strong>
                <pre><code>flutter run</code></pre>
            </li>
        </ol>

        <h2>Configuration</h2>
        <ol>
            <li><strong>Firebase Setup:</strong> 
                <ul>
                    <li>Create a Firebase project and configure authentication, real-time database, and Firestore.</li>
                    <li>Download the <code>google-services.json</code> file and place it in the <code>android/app</code> directory.</li>
                    <li>Download the <code>GoogleService-Info.plist</code> file and place it in the <code>ios/Runner</code> directory.</li>
                </ul>
            </li>
            <li><strong>Stripe Setup:</strong>
                <ul>
                    <li>Set up a Stripe account and obtain the necessary API keys.</li>
                    <li>Configure the Stripe integration in the application.</li>
                </ul>
            </li>
        </ol>

        <h2>Usage</h2>
        <ul>
            <li><strong>Client Side:</strong> Open the app to browse products, view details, and complete purchases.</li>
            <li><strong>Admin Side:</strong> Access the admin interface to manage products, orders, and user data.</li>
        </ul>

        <h2>Contributing</h2>
        <p>Feel free to open issues or submit pull requests if you have suggestions or improvements. Contributions are welcome!</p>

        <h2>License</h2>
        <p>This project is licensed under the MIT License. See the <a href="LICENSE">LICENSE</a> file for more details.</p>

        <h2>Contact</h2>
        <p>For any questions or collaboration inquiries, feel free to reach out to me via <a href="mailto:your-email@example.com">your-email@example.com</a> or connect with me on <a href="https://linkedin.com/in/your-profile">LinkedIn</a> / <a href="https://twitter.com/your-profile">Twitter</a>.</p>

        <div class="hashtags">
            <span class="hashtag">#FlutterDev</span>
            <span class="hashtag">#Ecommerce</span>
            <span class="hashtag">#MobileAppDevelopment</span>
            <span class="hashtag">#Firebase</span>
            <span class="hashtag">#StripePayments</span>
            <span class="hashtag">#StateManagement</span>
            <span class="hashtag">#UIUXDesign</span>
            <span class="hashtag">#TechInnovation</span>
        </div>
    </div>
</body>
</html>
