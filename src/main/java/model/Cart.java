package model;

import java.util.List;

public class Cart {
    private int id;
    private int customerId;
    private List<CartItem> cartItems;

    public Cart() {
    }

    public Cart(int id, int customerId, List<CartItem> cartItems) {
        this.id = id;
        this.customerId = customerId;
        this.cartItems = cartItems;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public List<CartItem> getCartItems() {
        return cartItems;
    }

    public void setCartItems(List<CartItem> cartItems) {
        this.cartItems = cartItems;
    }
}