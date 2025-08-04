package com.pahana_edu.mypro.DAO;

import com.pahana_edu.mypro.model.Customer;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {
    private Connection connection;

    public CustomerDAO(Connection connection) {
        this.connection = connection;
    }

    // Add a new customer
    public boolean addCustomer(Customer customer) throws SQLException {
        String query = "INSERT INTO customers (name, email, phone, dob, address, city, country, status, notes, photo_path) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, customer.getName());
            statement.setString(2, customer.getEmail());
            statement.setString(3, customer.getPhone());
            statement.setDate(4, customer.getDob() != null ? Date.valueOf(customer.getDob()) : null);
            statement.setString(5, customer.getAddress());
            statement.setString(6, customer.getCity());
            statement.setString(7, customer.getCountry());
            statement.setBoolean(8, customer.isActive());
            statement.setString(9, customer.getNotes());
            statement.setString(10, customer.getPhotoPath());

            return statement.executeUpdate() > 0;
        }
    }

    // Get all customers
    public List<Customer> getAllCustomers() throws SQLException {
        List<Customer> customers = new ArrayList<>();
        String query = "SELECT * FROM customers";

        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {

            while (resultSet.next()) {
                Customer customer = new Customer();
                customer.setId(resultSet.getInt("id"));
                customer.setName(resultSet.getString("name"));
                customer.setEmail(resultSet.getString("email"));
                customer.setPhone(resultSet.getString("phone"));
                Date dob = resultSet.getDate("dob");
                customer.setDob(dob != null ? dob.toLocalDate() : null);
                customer.setAddress(resultSet.getString("address"));
                customer.setCity(resultSet.getString("city"));
                customer.setCountry(resultSet.getString("country"));
                customer.setActive(resultSet.getBoolean("status"));
                customer.setNotes(resultSet.getString("notes"));
                customer.setPhotoPath(resultSet.getString("photo_path"));

                customers.add(customer);
            }
        }

        return customers;
    }

    // Get customer by ID
    public Customer getCustomerById(int id) throws SQLException {
        String query = "SELECT * FROM customers WHERE id = ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, id);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    Customer customer = new Customer();
                    customer.setId(resultSet.getInt("id"));
                    customer.setName(resultSet.getString("name"));
                    customer.setEmail(resultSet.getString("email"));
                    customer.setPhone(resultSet.getString("phone"));
                    Date dob = resultSet.getDate("dob");
                    customer.setDob(dob != null ? dob.toLocalDate() : null);
                    customer.setAddress(resultSet.getString("address"));
                    customer.setCity(resultSet.getString("city"));
                    customer.setCountry(resultSet.getString("country"));
                    customer.setActive(resultSet.getBoolean("status"));
                    customer.setNotes(resultSet.getString("notes"));
                    customer.setPhotoPath(resultSet.getString("photo_path"));

                    return customer;
                }
            }
        }

        return null;
    }

    // Update customer
    public boolean updateCustomer(Customer customer) throws SQLException {
        String query = "UPDATE customers SET name = ?, email = ?, phone = ?, dob = ?, address = ?, " +
                "city = ?, country = ?, status = ?, notes = ?, photo_path = ? WHERE id = ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, customer.getName());
            statement.setString(2, customer.getEmail());
            statement.setString(3, customer.getPhone());
            statement.setDate(4, customer.getDob() != null ? Date.valueOf(customer.getDob()) : null);
            statement.setString(5, customer.getAddress());
            statement.setString(6, customer.getCity());
            statement.setString(7, customer.getCountry());
            statement.setBoolean(8, customer.isActive());
            statement.setString(9, customer.getNotes());
            statement.setString(10, customer.getPhotoPath());
            statement.setInt(11, customer.getId());

            return statement.executeUpdate() > 0;
        }
    }


    

    // Delete customer
    public boolean deleteCustomer(int id) throws SQLException {
        String query = "DELETE FROM customers WHERE id = ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, id);
            return statement.executeUpdate() > 0;
        }
    }


}
