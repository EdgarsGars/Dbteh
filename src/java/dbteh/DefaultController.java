/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbteh;

import DbConn.AccountRepository;
import DbConn.ProjectRepository;
import DbConn.TaskRepository;
import Entities.Employee;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

/**
 *
 * @author Edgar
 */
@Controller
@SessionAttributes("user")
public class DefaultController {

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String index(ModelMap map, HttpSession session) {
        if (session.getAttribute("user") != null) {
            return "index";
        } else {
            return "redirect:/login";
        }
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(ModelMap map, HttpSession session) {
        return "login";
    }

    @RequestMapping(value = "/auth", method = RequestMethod.POST)
    public String auth(@RequestParam("username") String username,
            @RequestParam("password") String password, ModelMap map,
            HttpSession session) {
        Employee e = AccountRepository.login(username, password);
        if (e != null) {
            session.setAttribute("user", e);
            return "redirect:/";
        } else {
            return "redirect:/login?error=1";
        }
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(ModelMap map, HttpSession session, SessionStatus status) {
        session.setAttribute("user", null);
        status.setComplete();
        return "redirect:/login";
    }

    @RequestMapping(value = "/tasks", method = RequestMethod.GET)
    public String tasks(ModelMap map, HttpSession session, SessionStatus status) {
        System.out.println("Controller ID -> " + ((Employee) session.getAttribute("user")).getAccountID());
        return "issues";
    }

    @RequestMapping(value = "/projects", method = RequestMethod.GET)
    public String projects(ModelMap map, HttpSession session, SessionStatus status) {
        if (session.getAttribute("user") != null) {
            return "projectListPage";
        } else {
            return "redirect:/login";
        }
    }

    @RequestMapping(value = "/projectCreation", method = RequestMethod.GET)
    public String projectCreation(ModelMap map, HttpSession session, SessionStatus status) {
        if (session.getAttribute("user") != null) {
            return "projectCreation";
        } else {
            return "redirect:/login";
        }
    }

    @RequestMapping(value = "/addProject", method = RequestMethod.POST)
    public String addProject(@RequestParam("projectName") String name,
            @RequestParam("description") String description, ModelMap map,
            HttpSession session) {
        if (session.getAttribute("user") != null) {
            if (ProjectRepository.createProject(name, description, (Employee) session.getAttribute("user"))) {
                return "redirect:/projects";
            }
        }
        return "redirect:/projectCreation?error=1";
    }

    @RequestMapping(value = "/project", method = RequestMethod.GET)
    public String projectPage(@RequestParam("projectID") int id, ModelMap map, HttpSession session, SessionStatus status) {
        if (session.getAttribute("user") != null) {
            map.put("projectID", id);
            return "projectPage";
        } else {
            return "redirect:/login";
        }
    }

    @RequestMapping(value = "/task", method = RequestMethod.GET)
    public String taskPage(@RequestParam("taskID") int id, ModelMap map, HttpSession session, SessionStatus status) {
        if (session.getAttribute("user") != null) {
            map.put("taskID", id);
            return "issuePage";
        } else {
            return "redirect:/login";
        }
    }

    //postComment
    @RequestMapping(value = "/postComment", method = RequestMethod.POST)
    public String postComment(@RequestParam("commentInput") String text, @RequestParam("taskID") int taskID, @RequestParam("accountID") int accountID, ModelMap map, HttpSession session, SessionStatus status) {
        TaskRepository.addComment(taskID, accountID, text);
        return "redirect:/task?taskID=" + taskID;
    }

    ////Dbteh/updateTask?taskID=<%=taskID%>&status="+comboBoxSelectedText('statusSelect','text')+
    // "&priority="+comboBoxSelectedText('priority','text')+"&accountID="+comboBoxSelectedText('assignee','value')+
    //    "&description="+document.getElementById('description').value;
    @RequestMapping(value = "/updateTask", method = RequestMethod.GET)
    public String updateTask(@RequestParam("taskID") int taskID, @RequestParam("status") String taskStatus, @RequestParam("priority") String taskPriority, @RequestParam("accountID") int accountID, @RequestParam("description") String description, ModelMap map, HttpSession session, SessionStatus status) {
        TaskRepository.updateTask(taskID, accountID, taskStatus, taskPriority, description);
        return "redirect:/task?taskID=" + taskID;

    }

    @RequestMapping(value = "/newTask", method = RequestMethod.POST)
    public String newTaskPage(@RequestParam("projectID") int projectID, ModelMap map, HttpSession session, SessionStatus status) {
        map.put("projectID", projectID);
        return "newTask";

    }
    
    //"/Dbteh/createTask?taskID=<%=projectID%>&status=" + comboBoxSelectedText('statusSelect', 'text') +
                        //"&priority=" + comboBoxSelectedText('priority', 'text') + "&accountID=" + comboBoxSelectedText('assignee', 'value') +
                       // "&description=" + document.getElementById('description').value + "&parentID=" + comboBoxSelectedText('parentTask', 'text') + "&type=" + comboBoxSelectedText('typeSelect', 'text');
    @RequestMapping(value = "/createTask", method = RequestMethod.GET)
    public String createTask(@RequestParam("projectID") int projectID, @RequestParam("status") String taskStatus, @RequestParam("priority") String taskPriority,@RequestParam("type") String type, @RequestParam("accountID") int accountID, @RequestParam("description") String description, @RequestParam("parentID") String parent,@RequestParam("subject") String subject,ModelMap map, HttpSession session, SessionStatus status) {
        
        Employee e = (Employee)session.getAttribute("user");
        TaskRepository.insertTask(projectID, taskStatus, taskPriority, type, accountID, description, parent, subject, e.accountID);
        
        
        return "redirect:/";

    }
    
    @RequestMapping(value = "/employees", method = RequestMethod.POST)
    public String employees(@RequestParam("projectID") int projectID, ModelMap map, HttpSession session, SessionStatus status) {
        map.put("projectID", projectID);
        return "addMemberToProject";

    }
    
    
    //addMember
    @RequestMapping(value = "/addMember", method = RequestMethod.GET)
    public String addMember(@RequestParam("projectID") int projectID,@RequestParam("memberID") int accountID,@RequestParam("role") String role, ModelMap map, HttpSession session, SessionStatus status) {
        ProjectRepository.addMember(accountID, projectID, role);
        return "redirect:/project?projectID="+projectID;

    }
}
