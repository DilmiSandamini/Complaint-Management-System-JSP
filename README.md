# 🛠️ Complaint Management System (CMS)

A simple and elegant Complaint Management System built with Jakarta EE, Tomcat, MySQL, JSP, Servlets, Bootstrap, and JavaScript. It supports both Admin and Employee functionalities.

---

## 🚀 Technologies Used

- Jakarta EE (`jakarta.servlet-api`, `jakarta.annotation`)
- Apache Tomcat (11+)
- MySQL (via `mysql-connector-j`)
- Apache Commons DBCP2 (Tomcat built-in connection pooling)
- Bootstrap 5
- JSP + Servlets
- Java 21
- Maven
- Lombok (for model simplification)

---

## 📚 Features

### 🔒 Admin Panel

- 👀 View all complaints submitted by all employees  
- 📝 Add remarks and update complaint status  
- 🟢/🔴 View live status of each complaint  
- 🧠 Session handling for secure admin-only access  

### 🧑‍💼 Employee Panel

- 📝 Submit new complaints  
- 📋 View only their own submitted complaints  
- 📨 Get real-time status updates and admin remarks  
- ✅ Form validations with JavaScript  

---

⚙️ Setup Instructions

01.Clone the repo:
  git clone https://github.com/yourusername/CMS.git
  
02.Import into IntelliJ IDEA or any Java IDE with Maven support.

03.Database Setup:

        Run the SQL script in resources/db/schema.sql on your MySQL server.
        Create a DB named cms or update context.xml accordingly.
    
04.Configure Connection Pool (context.xml):

05.Deploy on Tomcat:

        Use Tomcat 11+ and deploy the CMS project.
        Visit: http://localhost:8080/ComplaintManagementSystem/jsp/signin.jsp to start.
        
---

🧑‍💼 Employee Features

Employees can:
 - Submit complaints via form
 - Track complaint status
 - View admin remarks
 - Edit/Delete pending complaints

Key Files:
 - dashboard-employee.jsp
 - my-complaints.jsp
 - EmployeeServlet.java
 - ComplaintModel.java

---

🛠️ Admin Features

Admins can:
 - View and manage all complaints
 - Change complaint status
 - Add admin remarks

Key Files:
- dashboard-admin.jsp
- update-complaint.jsp
- AdminServlet.java

---

🤝 Contributing

Pull requests are welcome! If you'd like to contribute, fork the repo and submit a PR.



      

