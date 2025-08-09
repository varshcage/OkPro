<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Billing - PahanEdu Bookshop</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    ::-webkit-scrollbar {
      width: 8px;
    }
    ::-webkit-scrollbar-track {
      background: #f1f1f1;
    }
    ::-webkit-scrollbar-thumb {
      background: #888;
      border-radius: 4px;
    }
    ::-webkit-scrollbar-thumb:hover {
      background: #555;
    }

    .notification {
      animation: slideIn 0.3s ease-out, fadeOut 0.5s ease 3s forwards;
    }

    @keyframes slideIn {
      from { transform: translateX(100%); }
      to { transform: translateX(0); }
    }

    @keyframes fadeOut {
      from { opacity: 1; }
      to { opacity: 0; }
    }

    @media print {
      body * {
        visibility: hidden;
      }
      #printable-bill, #printable-bill * {
        visibility: visible;
      }
      #printable-bill {
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
      }
      .no-print {
        display: none !important;
      }
    }
  </style>
</head>
<body class="bg-gray-50 font-sans">
<!-- Notification Area -->
<div id="notification-area" class="fixed top-4 right-4 z-50 space-y-2">
  <c:if test="${not empty message}">
    <div class="notification px-4 py-3 rounded-md shadow-md flex items-center
                ${message.type == 'success' ? 'bg-green-100 text-green-800' :
                  message.type == 'error' ? 'bg-red-100 text-red-800' :
                  'bg-blue-100 text-blue-800'}">
      <i class="fas ${message.type == 'success' ? 'fa-check-circle' :
                               message.type == 'error' ? 'fa-exclamation-circle' :
                               'fa-info-circle'} mr-2"></i>
        ${message.text}
    </div>
  </c:if>
</div>

<!-- Sidebar -->
<div class="fixed inset-y-0 left-0 transform -translate-x-full md:translate-x-0 transition duration-200 ease-in-out z-40 w-64 bg-indigo-800 text-white shadow-lg">
  <div class="flex items-center justify-center h-16 px-4 border-b border-indigo-700">
    <div class="flex items-center space-x-2">
      <i class="fas fa-book-open text-2xl text-indigo-300"></i>
      <span class="text-xl font-bold">PahanEdu</span>
    </div>
  </div>
  <nav class="mt-6">
    <div class="px-4 space-y-1">
      <a href="AdminDashboardServlet" class="flex items-center px-4 py-3 text-indigo-200 hover:text-white hover:bg-indigo-700 rounded-lg">
        <i class="fas fa-tachometer-alt mr-3"></i>
        Dashboard
      </a>
      <a href="BookServlet" class="flex items-center px-4 py-3 text-indigo-200 hover:text-white hover:bg-indigo-700 rounded-lg">
        <i class="fas fa-book mr-3"></i>
        Books
      </a>
      <a href="CustomerServlet" class="flex items-center px-4 py-3 text-indigo-200 hover:text-white hover:bg-indigo-700 rounded-lg">
        <i class="fas fa-users mr-3"></i>
        Customers
      </a>
      <a href="Bill.jsp" class="flex items-center px-4 py-3 text-white bg-indigo-900 rounded-lg">
        <i class="fa-solid fa-money-bill mr-3"></i>
        Billing
      </a>
      <a href="#" class="flex items-center px-4 py-3 text-indigo-200 hover:text-white hover:bg-indigo-700 rounded-lg">
        <i class="fas fa-chart-line mr-3"></i>
        Reports
      </a>
    </div>
  </nav>
  <div class="absolute bottom-0 w-full p-4 border-t border-indigo-700">
    <div class="flex items-center">
      <img class="w-10 h-10 rounded-full bg-gray-200" src="" alt="Profile">
      <div class="ml-3">
        <p class="text-sm font-medium">Admin</p>
        <p class="text-xs text-indigo-300">Administrator</p>
      </div>
    </div>
  </div>
</div>

<!-- Mobile sidebar toggle -->
<div class="md:hidden fixed top-4 left-4 z-40">
  <button id="sidebar-toggle" class="p-2 rounded-md bg-indigo-800 text-white focus:outline-none">
    <i class="fas fa-bars"></i>
  </button>
</div>

<!-- Main Content -->
<div class="md:ml-64 min-h-screen">
  <!-- Header -->
  <header class="bg-white shadow-sm">
    <div class="flex justify-between items-center px-6 py-4">
      <h1 class="text-2xl font-semibold text-gray-800">Billing</h1>
      <div class="flex items-center space-x-4">
        <div class="relative">
          <button class="p-2 rounded-full hover:bg-gray-100">
            <i class="fas fa-bell text-gray-600"></i>
            <span class="absolute top-0 right-0 w-2 h-2 bg-red-500 rounded-full"></span>
          </button>
        </div>
        <div class="relative">
          <input type="text" placeholder="Search..." class="pl-10 pr-4 py-2 border rounded-full focus:outline-none focus:ring-2 focus:ring-indigo-500">
          <i class="fas fa-search absolute left-3 top-3 text-gray-400"></i>
        </div>
      </div>
    </div>
  </header>

  <!-- Main Content Area -->
  <main class="p-6">
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
      <!-- Customer and Book Selection -->
      <div class="lg:col-span-2 space-y-6">
        <!-- Customer Selection -->
        <div class="bg-white p-6 rounded-lg shadow">
          <h2 class="text-lg font-semibold text-gray-800 mb-4">Select Customer</h2>
          <div class="flex flex-col md:flex-row gap-4">
            <div class="flex-1">
              <label class="block text-sm font-medium text-gray-700 mb-1">Search Customer</label>
              <div class="relative">
                <input type="text" id="customer-search" placeholder="Search by name or email..."
                       class="w-full pl-10 pr-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500">
                <i class="fas fa-search absolute left-3 top-3 text-gray-400"></i>
              </div>
            </div>
            <div class="w-full md:w-48">
              <label class="block text-sm font-medium text-gray-700 mb-1">Or Select</label>
              <select id="customer-select" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500">
                <option value="">Select Customer</option>
                <c:forEach var="customer" items="${customers}">
                  <option value="${customer.id}" data-name="${customer.name}" data-email="${customer.email}"
                          data-phone="${customer.phone}" data-address="${customer.address}">
                      ${customer.name} (${customer.email})
                  </option>
                </c:forEach>
              </select>
            </div>
          </div>

          <!-- Selected Customer Info -->
          <div id="selected-customer-info" class="mt-4 p-4 bg-gray-50 rounded-lg hidden">
            <div class="flex items-center space-x-4">
              <div class="relative w-12 h-12">
                <img id="customer-photo" src="" alt="Customer Photo"
                     class="w-12 h-12 rounded-full object-cover border border-gray-300"
                     onerror="this.style.display='none'; this.nextElementSibling.style.display='inline-block';">
                <i class="fas fa-user-circle text-gray-400 text-3xl absolute top-0 left-0" style="display:none;"></i>
              </div>
              <div>
                <h3 id="customer-name" class="font-medium text-gray-800"></h3>
                <p id="customer-email" class="text-sm text-gray-600"></p>
              </div>
            </div>
            <div class="mt-3 grid grid-cols-2 gap-2 text-sm">
              <div>
                <span class="text-gray-500">Phone:</span>
                <span id="customer-phone" class="text-gray-700"></span>
              </div>
              <div>
                <span class="text-gray-500">Address:</span>
                <span id="customer-address" class="text-gray-700"></span>
              </div>
            </div>
          </div>
        </div>

        <!-- Book Selection -->
        <div class="bg-white p-6 rounded-lg shadow">
          <h2 class="text-lg font-semibold text-gray-800 mb-4">Add Books</h2>
          <div class="flex flex-col md:flex-row gap-4">
            <div class="flex-1">
              <label class="block text-sm font-medium text-gray-700 mb-1">Search Books</label>
              <div class="relative">
                <input type="text" id="book-search" placeholder="Search by title, author or ISBN..."
                       class="w-full pl-10 pr-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500">
                <i class="fas fa-search absolute left-3 top-3 text-gray-400"></i>
              </div>
            </div>
            <div class="w-full md:w-48">
              <label class="block text-sm font-medium text-gray-700 mb-1">Or Select</label>
              <select id="book-select" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500">
                <option value="">Select Book</option>
                <c:forEach var="book" items="${books}">
                  <option value="${book.id}" data-title="${book.title}" data-author="${book.author}"
                          data-isbn="${book.isbn}" data-price="${book.price}" data-stock="${book.stock}">
                      ${book.title} (${book.author})
                  </option>
                </c:forEach>
              </select>
            </div>
          </div>

          <!-- Selected Book Info -->
          <div id="selected-book-info" class="mt-4 p-4 bg-gray-50 rounded-lg hidden">
            <div class="flex items-start space-x-4">
              <div class="relative w-16 h-20 flex-shrink-0">
                <img id="book-cover" src="" alt="Book Cover"
                     class="w-16 h-20 object-cover border border-gray-300 rounded"
                     onerror="this.style.display='none'; this.nextElementSibling.style.display='inline-block';">
                <i class="fas fa-book text-gray-400 text-4xl absolute top-0 left-0" style="display:none;"></i>
              </div>
              <div class="flex-1">
                <h3 id="book-title" class="font-medium text-gray-800"></h3>
                <p id="book-author" class="text-sm text-gray-600"></p>
                <div class="mt-2 grid grid-cols-2 gap-2 text-sm">
                  <div>
                    <span class="text-gray-500">ISBN:</span>
                    <span id="book-isbn" class="text-gray-700"></span>
                  </div>
                  <div>
                    <span class="text-gray-500">Price:</span>
                    <span id="book-price" class="text-gray-700"></span>
                  </div>
                  <div>
                    <span class="text-gray-500">Stock:</span>
                    <span id="book-stock" class="text-gray-700"></span>
                  </div>
                </div>
              </div>
            </div>
            <div class="mt-3 flex items-center space-x-4">
              <div class="w-24">
                <label class="block text-sm font-medium text-gray-700 mb-1">Quantity</label>
                <input type="number" id="book-quantity" min="1" value="1"
                       class="w-full px-3 py-1 border rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500">
              </div>
              <button id="add-book-btn" class="mt-5 px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500">
                Add to Bill
              </button>
            </div>
          </div>
        </div>

        <!-- Added Books Table -->
        <div class="bg-white p-6 rounded-lg shadow">
          <h2 class="text-lg font-semibold text-gray-800 mb-4">Items in Bill</h2>
          <div class="overflow-x-auto">
            <table class="w-full text-left table-auto border-collapse">
              <thead>
              <tr class="bg-gray-100">
                <th class="px-4 py-2">Book</th>
                <th class="px-4 py-2">Price</th>
                <th class="px-4 py-2">Qty</th>
                <th class="px-4 py-2">Total</th>
                <th class="px-4 py-2">Action</th>
              </tr>
              </thead>
              <tbody id="bill-items">
              <!-- Items will be added here dynamically -->
              <tr id="no-items-row">
                <td colspan="5" class="px-4 py-6 text-center text-gray-500">No items added to the bill yet</td>
              </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <!-- Bill Summary -->
      <div class="space-y-6">
        <div class="bg-white p-6 rounded-lg shadow sticky top-6">
          <h2 class="text-lg font-semibold text-gray-800 mb-4">Bill Summary</h2>

          <div class="space-y-3">
            <div class="flex justify-between">
              <span class="text-gray-600">Subtotal:</span>
              <span id="subtotal" class="font-medium">$0.00</span>
            </div>

            <div class="flex justify-between">
              <span class="text-gray-600">Discount:</span>
              <div class="flex items-center">
                <input type="number" id="discount-percent" min="0" max="100" value="0"
                       class="w-16 px-2 py-1 border rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500">
                <span class="ml-1">%</span>
                <span id="discount-amount" class="ml-3 font-medium">$0.00</span>
              </div>
            </div>

            <div class="pt-3 border-t">
              <div class="flex justify-between">
                <span class="text-gray-600">Tax (10%):</span>
                <span id="tax-amount" class="font-medium">$0.00</span>
              </div>
            </div>

            <div class="pt-3 border-t">
              <div class="flex justify-between">
                <span class="text-lg font-semibold text-gray-800">Total:</span>
                <span id="total-amount" class="text-lg font-bold text-indigo-600">$0.00</span>
              </div>
            </div>
          </div>

          <div class="mt-6 space-y-3">
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">Payment Method</label>
              <select id="payment-method" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500">
                <option value="cash">Cash</option>
                <option value="card">Credit/Debit Card</option>
                <option value="transfer">Bank Transfer</option>
              </select>
            </div>

            <div id="cash-payment-fields" class="hidden">
              <div class="mt-2">
                <label class="block text-sm font-medium text-gray-700 mb-1">Amount Received</label>
                <input type="number" id="amount-received" min="0" step="0.01"
                       class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500">
              </div>
              <div class="mt-1">
                <span class="text-sm text-gray-600">Change:</span>
                <span id="change-amount" class="text-sm font-medium ml-2">$0.00</span>
              </div>
            </div>

            <div id="card-payment-fields" class="hidden">
              <div class="mt-2">
                <label class="block text-sm font-medium text-gray-700 mb-1">Card Number</label>
                <input type="text" id="card-number" placeholder="1234 5678 9012 3456"
                       class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500">
              </div>
              <div class="grid grid-cols-2 gap-3 mt-2">
                <div>
                  <label class="block text-sm font-medium text-gray-700 mb-1">Expiry Date</label>
                  <input type="text" id="card-expiry" placeholder="MM/YY"
                         class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500">
                </div>
                <div>
                  <label class="block text-sm font-medium text-gray-700 mb-1">CVV</label>
                  <input type="text" id="card-cvv" placeholder="123"
                         class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500">
                </div>
              </div>
            </div>
          </div>

          <div class="mt-6 space-y-3">
            <button id="complete-bill-btn" class="w-full px-4 py-3 bg-green-600 text-white rounded-lg hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-green-500 font-medium">
              Complete Bill
            </button>
            <button id="print-bill-btn" class="w-full px-4 py-3 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 font-medium no-print">
              Print Bill
            </button>
            <button id="clear-bill-btn" class="w-full px-4 py-3 bg-gray-200 text-gray-800 rounded-lg hover:bg-gray-300 focus:outline-none focus:ring-2 focus:ring-gray-500 font-medium no-print">
              Clear Bill
            </button>
          </div>
        </div>
      </div>
    </div>
  </main>
</div>

<!-- Printable Bill (Hidden until printing) -->
<div id="printable-bill" class="hidden bg-white p-8 max-w-2xl mx-auto">
  <div class="text-center mb-6">
    <h1 class="text-3xl font-bold text-indigo-700">PahanEdu Bookshop</h1>
    <p class="text-gray-600">123 Education Street, Colombo, Sri Lanka</p>
    <p class="text-gray-600">Phone: +94 11 234 5678 | Email: info@pahanedu.com</p>
  </div>

  <div class="border-b-2 border-gray-300 pb-4 mb-4">
    <div class="flex justify-between items-start">
      <div>
        <h2 class="text-xl font-semibold">INVOICE</h2>
        <p class="text-gray-600">Invoice #: <span id="print-invoice-no">00123</span></p>
        <p class="text-gray-600">Date: <span id="print-date"><%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(new java.util.Date()) %></span></p>
      </div>
      <div class="text-right">
        <h3 class="font-medium">Customer</h3>
        <p id="print-customer-name" class="text-gray-700"></p>
        <p id="print-customer-phone" class="text-gray-700"></p>
      </div>
    </div>
  </div>

  <table class="w-full mb-6">
    <thead>
    <tr class="border-b border-gray-300">
      <th class="text-left py-2">Item</th>
      <th class="text-right py-2">Price</th>
      <th class="text-right py-2">Qty</th>
      <th class="text-right py-2">Total</th>
    </tr>
    </thead>
    <tbody id="print-items">
    <!-- Items will be added here -->
    </tbody>
  </table>

  <div class="border-t-2 border-gray-300 pt-4">
    <div class="flex justify-between mb-1">
      <span>Subtotal:</span>
      <span id="print-subtotal">$0.00</span>
    </div>
    <div class="flex justify-between mb-1">
      <span>Discount:</span>
      <span id="print-discount">$0.00</span>
    </div>
    <div class="flex justify-between mb-1">
      <span>Tax (10%):</span>
      <span id="print-tax">$0.00</span>
    </div>
    <div class="flex justify-between font-bold text-lg mt-3">
      <span>Total:</span>
      <span id="print-total">$0.00</span>
    </div>
  </div>

  <div class="mt-8 pt-4 border-t border-gray-300">
    <p class="text-gray-600 text-sm">Thank you for your purchase!</p>
    <p class="text-gray-600 text-sm">Items can be exchanged within 14 days with original receipt</p>
  </div>
</div>

<!-- Scripts -->
<script>
  // Toggle sidebar on mobile
  document.getElementById('sidebar-toggle').addEventListener('click', function() {
    document.querySelector('.fixed.inset-y-0.left-0').classList.toggle('-translate-x-full');
  });

  // Customer selection
  const customerSelect = document.getElementById('customer-select');
  const customerInfo = document.getElementById('selected-customer-info');

  customerSelect.addEventListener('change', function() {
    if (this.value) {
      const selectedOption = this.options[this.selectedIndex];
      document.getElementById('customer-name').textContent = selectedOption.dataset.name;
      document.getElementById('customer-email').textContent = selectedOption.dataset.email;
      document.getElementById('customer-phone').textContent = selectedOption.dataset.phone;
      document.getElementById('customer-address').textContent = selectedOption.dataset.address;

      // For printable bill
      document.getElementById('print-customer-name').textContent = selectedOption.dataset.name;
      document.getElementById('print-customer-phone').textContent = selectedOption.dataset.phone;

      customerInfo.classList.remove('hidden');
    } else {
      customerInfo.classList.add('hidden');
    }
  });

  // Book selection
  const bookSelect = document.getElementById('book-select');
  const bookInfo = document.getElementById('selected-book-info');

  bookSelect.addEventListener('change', function() {
    if (this.value) {
      const selectedOption = this.options[this.selectedIndex];
      document.getElementById('book-title').textContent = selectedOption.dataset.title;
      document.getElementById('book-author').textContent = selectedOption.dataset.author;
      document.getElementById('book-isbn').textContent = selectedOption.dataset.isbn;
      document.getElementById('book-price').textContent = '$' + parseFloat(selectedOption.dataset.price).toFixed(2);
      document.getElementById('book-stock').textContent = selectedOption.dataset.stock;

      // Reset quantity to 1
      document.getElementById('book-quantity').value = '1';

      bookInfo.classList.remove('hidden');
    } else {
      bookInfo.classList.add('hidden');
    }
  });

  // Payment method change
  const paymentMethod = document.getElementById('payment-method');
  const cashFields = document.getElementById('cash-payment-fields');
  const cardFields = document.getElementById('card-payment-fields');

  paymentMethod.addEventListener('change', function() {
    cashFields.classList.add('hidden');
    cardFields.classList.add('hidden');

    if (this.value === 'cash') {
      cashFields.classList.remove('hidden');
    } else if (this.value === 'card') {
      cardFields.classList.remove('hidden');
    }
  });

  // Calculate change for cash payment
  const amountReceived = document.getElementById('amount-received');
  amountReceived.addEventListener('input', function() {
    const total = parseFloat(document.getElementById('total-amount').textContent.replace('$', ''));
    const received = parseFloat(this.value) || 0;
    const change = received - total;
    document.getElementById('change-amount').textContent = '$' + (change > 0 ? change.toFixed(2) : '0.00');
  });

  // Bill items management
  let billItems = [];
  const billItemsTable = document.getElementById('bill-items');
  const noItemsRow = document.getElementById('no-items-row');

  function updateBillSummary() {
    let subtotal = 0;
    billItems.forEach(item => {
      subtotal += item.price * item.quantity;
    });

    const discountPercent = parseFloat(document.getElementById('discount-percent').value) || 0;
    const discountAmount = subtotal * (discountPercent / 100);
    const taxAmount = (subtotal - discountAmount) * 0.1; // 10% tax
    const totalAmount = subtotal - discountAmount + taxAmount;

    document.getElementById('subtotal').textContent = '$' + subtotal.toFixed(2);
    document.getElementById('discount-amount').textContent = '$' + discountAmount.toFixed(2);
    document.getElementById('tax-amount').textContent = '$' + taxAmount.toFixed(2);
    document.getElementById('total-amount').textContent = '$' + totalAmount.toFixed(2);

    // Update printable bill
    document.getElementById('print-subtotal').textContent = '$' + subtotal.toFixed(2);
    document.getElementById('print-discount').textContent = '$' + discountAmount.toFixed(2);
    document.getElementById('print-tax').textContent = '$' + taxAmount.toFixed(2);
    document.getElementById('print-total').textContent = '$' + totalAmount.toFixed(2);
  }

  function renderBillItems() {
    // Clear existing rows except the "no items" row
    while (billItemsTable.firstChild) {
      billItemsTable.removeChild(billItemsTable.firstChild);
    }

    if (billItems.length === 0) {
      billItemsTable.appendChild(noItemsRow);
      noItemsRow.classList.remove('hidden');
      return;
    }

    noItemsRow.classList.add('hidden');

    billItems.forEach((item, index) => {
      const row = document.createElement('tr');
      row.className = 'border-b';
      row.innerHTML = `
        <td class="px-4 py-2">${item.title}</td>
        <td class="px-4 py-2 text-right">$${item.price.toFixed(2)}</td>
        <td class="px-4 py-2 text-right">${item.quantity}</td>
        <td class="px-4 py-2 text-right">$${(item.price * item.quantity).toFixed(2)}</td>
        <td class="px-4 py-2 text-center">
          <button class="remove-item-btn p-1 text-red-500 hover:text-red-700" data-index="${index}">
            <i class="fas fa-trash"></i>
          </button>
        </td>
      `;
      billItemsTable.appendChild(row);
    });

    // Render printable items
    const printItems = document.getElementById('print-items');
    printItems.innerHTML = '';

    billItems.forEach(item => {
      const row = document.createElement('tr');
      row.className = 'border-b border-gray-300';
      row.innerHTML = `
        <td class="py-2">${item.title}</td>
        <td class="py-2 text-right">$${item.price.toFixed(2)}</td>
        <td class="py-2 text-right">${item.quantity}</td>
        <td class="py-2 text-right">$${(item.price * item.quantity).toFixed(2)}</td>
      `;
      printItems.appendChild(row);
    });

    updateBillSummary();
  }

  // Add book to bill
  document.getElementById('add-book-btn').addEventListener('click', function() {
    if (!bookSelect.value) {
      alert('Please select a book first');
      return;
    }

    const selectedOption = bookSelect.options[bookSelect.selectedIndex];
    const quantity = parseInt(document.getElementById('book-quantity').value) || 1;
    const stock = parseInt(selectedOption.dataset.stock);

    if (quantity > stock) {
      alert(`Only ${stock} copies available in stock`);
      return;
    }

    const newItem = {
      id: bookSelect.value,
      title: selectedOption.dataset.title,
      price: parseFloat(selectedOption.dataset.price),
      quantity: quantity
    };

    // Check if item already exists in bill
    const existingItemIndex = billItems.findIndex(item => item.id === newItem.id);
    if (existingItemIndex !== -1) {
      billItems[existingItemIndex].quantity += newItem.quantity;
    } else {
      billItems.push(newItem);
    }

    renderBillItems();
    bookSelect.value = '';
    bookInfo.classList.add('hidden');
  });

  // Remove item from bill
  billItemsTable.addEventListener('click', function(e) {
    if (e.target.classList.contains('remove-item-btn') || e.target.closest('.remove-item-btn')) {
      const button = e.target.classList.contains('remove-item-btn') ? e.target : e.target.closest('.remove-item-btn');
      const index = parseInt(button.dataset.index);
      billItems.splice(index, 1);
      renderBillItems();
    }
  });

  // Discount change
  document.getElementById('discount-percent').addEventListener('input', updateBillSummary);

  // Complete bill
  document.getElementById('complete-bill-btn').addEventListener('click', function() {
    if (billItems.length === 0) {
      alert('Please add items to the bill first');
      return;
    }

    if (!customerSelect.value) {
      alert('Please select a customer first');
      return;
    }

    // Here you would typically send the bill data to the server
    // For this example, we'll just show a success message
    alert('Bill completed successfully!');

    // Generate a random invoice number for demo
    const invoiceNo = 'INV-' + Math.floor(10000 + Math.random() * 90000);
    document.getElementById('print-invoice-no').textContent = invoiceNo;
  });

  // Print bill
  document.getElementById('print-bill-btn').addEventListener('click', function() {
    if (billItems.length === 0) {
      alert('No items to print');
      return;
    }

    const printableBill = document.getElementById('printable-bill');
    printableBill.classList.remove('hidden');
    window.print();
    printableBill.classList.add('hidden');
  });

  // Clear bill
  document.getElementById('clear-bill-btn').addEventListener('click', function() {
    if (confirm('Are you sure you want to clear the current bill?')) {
      billItems = [];
      renderBillItems();
      customerSelect.value = '';
      customerInfo.classList.add('hidden');
      document.getElementById('discount-percent').value = '0';
      document.getElementById('payment-method').value = 'cash';
      document.getElementById('amount-received').value = '';
      document.getElementById('change-amount').textContent = '$0.00';
      cashFields.classList.add('hidden');
    }
  });
</script>
</body>
</html>