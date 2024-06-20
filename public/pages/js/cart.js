let cartItems = [];

function getCartItemsFromCookies() {
  const cookieValue = document.cookie.match(/cartItems=([^;]*)/);
  return cookieValue ? JSON.parse(cookieValue[1]) : [];
}

function saveCartItemsToCookies(cartItems) {
  const cookieValue = JSON.stringify(cartItems);
  document.cookie = `cartItems=${cookieValue};path=/`;
}

function addToCart(product) {
  const utCookie = getCookie('ut');
  if (!utCookie) {
    Swal.fire({
      position: "top-end",
      icon: "warning",
      title: "Please login first to add to cart",
      showConfirmButton: false,
      timer: 1500
    });
    return;
  }
  const cartItems = getCartItemsFromCookies();
  const existingItem = cartItems.find((item) => item.id === product.id);
  if (existingItem) {
      existingItem.quantity++;
  } else {
      const item = {
          id: product.id,
          name: product.name,
          type: product.type,
          carat: product.carat,
          price: product.price,
          image: product.image,
          quantity: 1
      };
      cartItems.push(item);
  }
  saveCartItemsToCookies(cartItems);
  updateCartCount(); // Update cart count immediately
  updateCartTable();
}

function updateCartCount() {
  const cartItems = getCartItemsFromCookies();
  document.cookie = "cartItemCount=" + cartItems.length + ";path=/";
}

function updateCartTable(items) {
  const cartTable = document.getElementById('cart-table');
  const cartItems = getCartItemsFromCookies();
  let tableHtml = `
    <thead>
      <tr>
        <th>No</th>
        <th>Name</th>
        <th>Image</th>
        <th>Type</th>
        <th>Carat</th>
        <th>Price</th>
        <th>Quantity</th>
        <th>Subtotal</th>
        <th>Action</th>
      </tr>
    </thead>
    <tfoot>
        <tr>
            <td colspan="7">Total:</td>
            <td id="total-price">$0.00</td>
        </tr>
    </tfoot>
  `;
  let total = 0;
  if (cartItems.length === 0) {
    tableHtml += `
      <tbody>
        <tr>
          <td colspan="8">No products in cart.</td>
        </tr>
      </tbody>
    `;
  } else {
    cartItems.forEach((item, index) => {
      const subtotal = item.price * item.quantity;
      total += subtotal;
      tableHtml += `
        <tbody>
          <tr>
            <td>${index + 1}</td>
            <td>${item.name}</td>
            <td><img src="${item.image}.png" width="100" height="100"></td>
            <td>${item.type}</td>
            <td>${item.carat}</td>
            <td>$${item.price}</td>
            <td>${item.quantity}</td>
            <td>$${subtotal.toFixed(2)}</td>
            <td><button onclick="removeFromCart(${index})">Remove</button></td>
          </tr>
        </tbody>
      `;
    });
  }
  cartTable.innerHTML = tableHtml;
  document.getElementById('total-price').innerText = `$${total.toFixed(2)}`;
  document.cookie = "cartItemCount=" + cartItems.length + ";path=/";
}

function removeFromCart(index) {
    const cartItems = getCartItemsFromCookies();
    if (index!== -1) {
        if (cartItems[index].quantity > 1) {
            cartItems[index].quantity--; 
        } else {
            cartItems.splice(index, 1); 
        }
        saveCartItemsToCookies(cartItems);
        updateCartTable();
        loadCartItems(); 
    }
}

function loadCartItems() {
    cartItems = getCartItemsFromCookies();
}

function init() {
    loadCartItems();
    updateCartTable(); 
}

init();