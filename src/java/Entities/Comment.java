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
public class Comment implements Serializable{
    public Employee author;
    public String time;
    public String text;
}
