/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entities;

import java.io.Serializable;

/**
 *
 * @author Edgar
 */
public class Employee implements Serializable {

    public int accountID;
    public String firstname;
    public String lastname;
    public String email;
    public int totalTasks;
    public int completedTasks;
    public double completionRate;
    public String role;

    public Employee(int accountID, String firstname, String lastname, String email) {
        this.accountID = accountID;
        this.firstname = firstname;
        this.lastname = lastname;
        this.email = email;
    }

    public Employee() {
    }

    public int getAccountID() {
        return accountID;
    }

    public String getFirstname() {
        return firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public String getEmail() {
        return email;
    }

}
