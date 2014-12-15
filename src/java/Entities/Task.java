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
public class Task implements Serializable{
    public int taskID;
    public int projectID;
    public int parentTask;
    public String status;
    public String type;
    public String priority;
    public String subject;
    public String description;
    public String startdDate;
    public String endDate;
    public double spentTime;
    public double progress;
    public Employee assigne;
    public Employee creator;

    
    
}
