
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Haven - Cashier Billing</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .bg-book-pattern {
            background-image: url('data:image/svg+xml;base64,PHN2Zy...');
        }
        .billing-card {
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1),
            0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        .input-field:focus {
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.3);
        }
        .cart-item:hover {
            background-color: #f9fafb;
        }
        .scrollbar-thin::-webkit-scrollbar {
            width: 6px;
        }
        .scrollbar-thin::-webkit-scrollbar-thumb {
            background-color: #c7d2fe;
            border-radius: 3px;
        }
    </style>
</head>
<body class="bg-gray-100 min-h-screen">
<!-- Header -->
<header class="bg-indigo-600 text-white shadow-md">
    <div class="container mx-auto px-4 py-3 flex justify-between items-center">
        <div class="flex items-center space-x-2">
            <i class="fas fa-cash-register text-2xl"></i>
            <h1 class="text-xl font-bold">Book Haven - Cashier Billing</h1>
        </div>
        <div class="flex items-center space-x-4">
            <span class="font-medium">Welcome, Cashier</span>
            <button class="p-2 rounded-full hover:bg-indigo-500">
                <i class="fas fa-sign-out-alt"></i>
            </button>
        </div>
    </div>
</header>

<div class="container mx-auto px-4 py-6">
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <!-- Left Column - Product Search/Selection -->
        <div class="lg:col-span-2">
            <div class="bg-white rounded-lg shadow-md p-6 mb-6">
                <h2 class="text-lg font-semibold mb-4 text-gray-800">Product Search</h2>
                <div class="flex space-x-2 mb-4">
                    <div class="flex-1 relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="fas fa-search text-gray-400"></i>
                        </div>
                        <input type="text" id="product-search"
                               class="input-field pl-10 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 py-2 border"
                               placeholder="Search by ISBN, title or author">
                    </div>
                    <button class="px-4 py-2 bg-indigo-600 text-white rounded-md hover:bg-indigo-700">
                        <i class="fas fa-search mr-2"></i>Search
                    </button>
                </div>

                <!-- Search Results -->
                <div class="border rounded-lg overflow-hidden">
                    <div class="bg-gray-50 px-4 py-2 border-b flex justify-between items-center">
                        <h3 class="font-medium text-gray-700">Search Results</h3>
                        <span class="text-sm text-gray-500">5 items found</span>
                    </div>
                    <div class="h-64 overflow-y-auto scrollbar-thin">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                            <tr>
                                <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Book</th>
                                <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Price</th>
                                <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Stock</th>
                                <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Action</th>
                            </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                            <tr class="hover:bg-gray-50">
                                <td class="px-4 py-3 whitespace-nowrap">
                                    <div class="flex items-center">
                                        <div class="flex-shrink-0 h-10 w-10 bg-gray-200 rounded-md flex items-center justify-center">
                                            <i class="fas fa-book text-gray-500"></i>
                                        </div>
                                        <div class="ml-4">
                                            <div class="text-sm font-medium text-gray-900">The Great Gatsby</div>
                                            <div class="text-sm text-gray-500">ISBN: 9780743273565</div>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-4 py-3 whitespace-nowrap text-sm text-gray-500">$12.99</td>
                                <td class="px-4 py-3 whitespace-nowrap text-sm text-gray-500">24</td>
                                <td class="px-4 py-3 whitespace-nowrap text-sm font-medium">
                                    <button class="text-indigo-600 hover:text-indigo-900">Add to Cart</button>
                                </td>
                            </tr>
                            <!-- More rows would be here -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Customer Information -->
            <div class="bg-white rounded-lg shadow-md p-6">
                <h2 class="text-lg font-semibold mb-4 text-gray-800">Customer Information</h2>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Customer Name</label>
                        <input type="text" class="input-field block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 py-2 border">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Phone Number</label>
                        <input type="text" class="input-field block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 py-2 border">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Email (Optional)</label>
                        <input type="email" class="input-field block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 py-2 border">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Membership ID</label>
                        <div class="flex">
                            <input type="text" class="input-field block w-full rounded-l-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 py-2 border">
                            <button class="px-3 py-2 bg-indigo-600 text-white rounded-r-md hover:bg-indigo-700">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Column - Cart & Payment -->
        <div class="lg:col-span-1">
            <div class="bg-white rounded-lg shadow-md p-6 sticky top-4">
                <h2 class="text-lg font-semibold mb-4 text-gray-800">Current Order</h2>

                <!-- Cart Items -->
                <div class="border rounded-lg mb-4">
                    <div class="bg-gray-50 px-4 py-2 border-b flex justify-between items-center">
                        <h3 class="font-medium text-gray-700">Items (3)</h3>
                        <button class="text-sm text-red-500 hover:text-red-700">
                            <i class="fas fa-trash-alt mr-1"></i>Clear All
                        </button>
                    </div>
                    <div class="h-64 overflow-y-auto scrollbar-thin">
                        <div class="divide-y divide-gray-200">
                            <!-- Cart Item 1 -->
                            <div class="p-3 cart-item flex justify-between">
                                <div>
                                    <div class="font-medium">The Great Gatsby</div>
                                    <div class="text-sm text-gray-500">$12.99 × 1</div>
                                </div>
                                <div class="flex items-center">
                                    <span class="font-medium mr-4">$12.99</span>
                                    <button class="text-red-500 hover:text-red-700">
                                        <i class="fas fa-times"></i>
                                    </button>
                                </div>
                            </div>
                            <!-- More cart items would be here -->
                        </div>
                    </div>
                </div>

                <!-- Order Summary -->
                <div class="border rounded-lg mb-4">
                    <div class="bg-gray-50 px-4 py-2 border-b">
                        <h3 class="font-medium text-gray-700">Order Summary</h3>
                    </div>
                    <div class="p-4">
                        <div class="flex justify-between mb-2">
                            <span class="text-gray-600">Subtotal</span>
                            <span class="font-medium">$38.97</span>
                        </div>
                        <div class="flex justify-between mb-2">
                            <span class="text-gray-600">Discount</span>
                            <span class="font-medium text-green-600">-$3.90</span>
                        </div>
                        <div class="flex justify-between mb-2">
                            <span class="text-gray-600">Tax (8%)</span>
                            <span class="font-medium">$2.81</span>
                        </div>
                        <div class="border-t my-2"></div>
                        <div class="flex justify-between font-bold text-lg">
                            <span>Total</span>
                            <span>$37.88</span>
                        </div>
                    </div>
                </div>

                <!-- Payment Options -->
                <div class="mb-4">
                    <h3 class="text-sm font-medium text-gray-700 mb-2">Payment Method</h3>
                    <div class="grid grid-cols-3 gap-2">
                        <button class="py-2 border rounded-md hover:bg-indigo-50 hover:border-indigo-200">
                            <i class="fas fa-money-bill-wave text-green-500"></i>
                            <span class="block text-xs mt-1">Cash</span>
                        </button>
                        <button class="py-2 border rounded-md hover:bg-indigo-50 hover:border-indigo-200">
                            <i class="fas fa-credit-card text-blue-500"></i>
                            <span class="block text-xs mt-1">Card</span>
                        </button>
                        <button class="py-2 border rounded-md hover:bg-indigo-50 hover:border-indigo-200">
                            <i class="fas fa-mobile-alt text-purple-500"></i>
                            <span class="block text-xs mt-1">Mobile</span>
                        </button>
                    </div>
                </div>

                <!-- Complete Order Button -->
                <button class="w-full py-3 bg-green-600 text-white rounded-md hover:bg-green-700 font-medium flex items-center justify-center">
                    <i class="fas fa-check-circle mr-2"></i> Complete Order ($37.88)
                </button>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Quantity adjustment functionality
        document.querySelectorAll('.quantity-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                const input = this.parentNode.querySelector('.quantity-input');
                let value = parseInt(input.value);
                if (this.classList.contains('decrease') {
                    value = value > 1 ? value - 1 : 1;
                } else {
                    value = value + 1;
                }
                input.value = value;
                // Here you would update the cart total
            });
        });

        // Payment method selection
        document.querySelectorAll('[data-payment-method]').forEach(btn => {
            btn.addEventListener('click', function() {
                document.querySelectorAll('[data-payment-method]').forEach(b => {
                    b.classList.remove('border-indigo-500', 'bg-indigo-50');
                });
                this.classList.add('border-indigo-500', 'bg-indigo-50');
                // Set the selected payment method
            });
        });
    });
</script>
</body>
</html>