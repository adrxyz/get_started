const http = require('http');
const fs = require('fs');
const path = require('path');

// Corrected product data with image file names from image_1.png to image_8.png
const products = [
    {
        "id": "1",
        "name": "Miso Soup",
        "description": "A classic Japanese soup made with miso paste and dashi.",
        "image": "images/image_1.png", // Corrected file name
        "price": 4,
        "category": "Soup",
        "foodType": "Veggie"
    },
    {
        "id": "2",
        "name": "Chicken Noodle Soup",
        "description": "A comforting soup with tender chicken, vegetables, and noodles.",
        "image": "images/image_2.png", // Corrected file name
        "price": 5,
        "category": "Soup",
        "foodType": "Poultry"
    },
    {
        "id": "3",
        "name": "Spicy Ramen",
        "description": "Fiery ramen with chili-infused broth, perfect for a cold day.",
        "image": "images/image_3.png", // Corrected file name
        "price": 5,
        "category": "Noodles",
        "foodType": "Meat"
    },
    {
        "id": "4",
        "name": "Tonkatsu Ramen",
        "description": "Rich and creamy pork broth with tender pork slices and fresh vegetables.",
        "image": "images/image_4.png", // Corrected file name
        "price": 4,
        "category": "Noodles",
        "foodType": "Meat"
    },
    {
        "id": "5",
        "name": "California Roll",
        "description": "Classic sushi roll with avocado, crab, and cucumber.",
        "image": "images/image_5.png", // Corrected file name
        "price": 7,
        "category": "Sushi",
        "foodType": "Seafood"
    },
    {
        "id": "6",
        "name": "Veggie Sushi",
        "description": "A fresh and light sushi roll with a variety of seasonal vegetables.",
        "image": "images/image_6.png", // Corrected file name
        "price": 6,
        "category": "Sushi",
        "foodType": "Veggie"
    },
    {
        "id": "7",
        "name": "Beef Bowl",
        "description": "A bowl of steamed rice topped with thinly sliced beef and onions.",
        "image": "images/image_7.png", // Corrected file name
        "price": 9,
        "category": "Rice",
        "foodType": "Meat"
    },
    {
        "id": "8",
        "name": "Tuna Salad",
        "description": "A refreshing salad with crisp greens and seared tuna.",
        "image": "images/image_8.png", // Corrected file name
        "price": 8,
        "category": "Salad",
        "foodType": "Seafood"
    }
];

const server = http.createServer((req, res) => {
    // Set the CORS headers to allow your app to access this server
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

    // Handle preflight requests for CORS
    if (req.method === 'OPTIONS') {
        res.writeHead(204);
        res.end();
        return;
    }

    // Handle the /products endpoint
    if (req.url === '/products' && req.method === 'GET') {
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify(products));
        return;
    }

    // Handle image serving for your app
    if (req.url.startsWith('/images/')) {
        const imagePath = path.join(__dirname, req.url);
        fs.readFile(imagePath, (err, data) => {
            if (err) {
                res.writeHead(404, { 'Content-Type': 'text/plain' });
                res.end('Image not found.');
                return;
            }
            res.writeHead(200, { 'Content-Type': 'image/png' });
            res.end(data);
        });
        return;
    }

    // Default response for all other requests
    res.writeHead(404, { 'Content-Type': 'text/plain' });
    res.end('Not Found.');
});

const PORT = 3000;

server.listen(PORT, '127.0.0.1', () => {
    console.log(`Server is running at http://127.0.0.1:${PORT}`);
});