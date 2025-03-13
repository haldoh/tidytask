### **Developer-Ready Specification: Personal Task Management App**  

#### **Table of Contents**  
1. **Project Overview**  
2. **Core Features & Requirements**  
3. **User Experience & Task Flow**  
4. **Technical Architecture**  
5. **Data Model & API Structure**  
6. **Error Handling & Validation**  
7. **Testing Plan**  

---

## **1. Project Overview**  
The Personal Task Management App is a cross-platform tool designed for tracking tasks with or without due dates, supporting categories, priorities, and recurring tasks. The goal is to provide a **low-friction input** method using **natural language processing (NLP)** to structure tasks efficiently.  

### **Key Highlights:**  
- Minimalist UI with **quick task entry**  
- Tasks categorized by **due date or labels**  
- **Natural language support** for parsing task attributes  
- **Recurring tasks with advanced patterns**  
- **Cloud sync via custom backend**  
- **Push notifications for reminders**  
- **Cross-platform: Web + Mobile**  

---

## **2. Core Features & Requirements**  

### **Task Management:**  
✔ Single-input field for task creation with **NLP parsing**  
✔ **Task attributes** include:  
   - **Title** (e.g., "Book doctor appointment")  
   - **Due date** (e.g., "before next Friday")  
   - **Categories** (Labels, e.g., `#Work`, `#Personal`)  
   - **Priority** (`Low`, `Medium`, `High`, `Urgent`) *(Defaults to Low if not specified)*  
   - **Recurring settings** (Advanced patterns supported)  
✔ **Task completion methods:**  
   - Checkbox (Web)  
   - Swipe gesture (Mobile)  
✔ **Triage area**: Newly parsed tasks labeled for later refinement  

### **Task Display & Organization:**  
✔ **Two primary task views:**  
   1. **Tasks with due dates** → Sorted by date, grouped (Today, This Week, etc.)  
   2. **Tasks without due dates** → Listed by category & priority (Jira-style board)  
✔ **Filtering & Sorting:**  
   - By **due date, category, priority**  
   - Last-used settings **remembered**  
✔ **Completed tasks:** Hidden by default, toggle to view  

### **Task Recurrence & Scheduling:**  
✔ **Recurring tasks require a due date**  
✔ **Advanced recurrence options**, including:  
   - Daily, Weekly, Monthly, Yearly  
   - Custom patterns: “every 3rd Wednesday,” “last Friday of the month”  
✔ **Skipping a recurrence ignores the skipped instance**  
✔ **Editing any instance allows modifying either:**  
   - The **single occurrence** (becomes standalone)  
   - The **entire series** (future occurrences only)  
✔ **Final recurring task disappears upon last completion**  
✔ **Future occurrences listed in order by due date**  

### **Notifications & Reminders:**  
✔ **Push notifications** for due tasks (FCM)  
✔ **Default reminder at due time**, with the ability to:  
   - Set multiple reminders per task  
   - Disable notifications per task  
✔ **Global toggle to enable/disable notifications**  

### **User Authentication & Sync:**  
✔ **OAuth (Google) & Magic Link (email-based login)**  
✔ **Cloud sync via custom backend**  

### **Customization & User Settings:**  
✔ **Theme selection:** Auto-detect OS setting + manual toggle  
✔ **Notification settings:** Control per task & globally  

### **Data Retention & Deletion:**  
✔ **Soft delete:** Tasks move to trash, auto-deleted after **30 days**  
✔ **Restore or permanently delete from trash**  

---

## **3. User Experience & Task Flow**  

### **Task Creation Flow:**  
1. **User enters a task** (e.g., “Pay rent every month on the 1st”)  
2. **NLP extracts structured data** → Title, due date, priority, recurrence  
3. **Task appears in the correct view** (Date-based or Category-based)  
4. **User can edit the task in a dedicated view**  

### **Task Completion Flow:**  
1. **User marks task as complete**  
   - **Checkbox (Web) / Swipe (Mobile)**  
2. **If recurring, next instance is scheduled** (Sorted by due date)  
3. **Completed task moves to ‘Completed’ section**  

---

## **4. Technical Architecture**  

### **Backend:**  
- **Framework:** Ruby on Rails  
- **Database:** PostgreSQL  
- **Auth:** Devise (OAuth + Magic Link)  
- **APIs:** REST  
- **Background Jobs:** Sidekiq for reminders, recurring tasks  

### **Frontend:**  
- **Web:** React.js  
- **Mobile:** React Native  
- **State Management:** Redux  

### **Infrastructure & CI/CD:**  
- **Push Notifications:** Firebase Cloud Messaging (FCM)  
- **Hosting & CI/CD:** To be decided  

---

## **5. Data Model & API Structure**  

### **Task Model:**  
| Field         | Type          | Description |  
|--------------|--------------|-------------|  
| id           | UUID         | Unique identifier |  
| title        | String       | Task name |  
| due_date     | DateTime     | Due date (nullable) |  
| categories   | Array[String] | Labels attached to the task |  
| priority     | Enum         | (`Low`, `Medium`, `High`, `Urgent`) |  
| recurring    | Boolean      | True if recurring |  
| recurrence_pattern | String | Recurrence rules (e.g., “weekly on Monday”) |  
| completed    | Boolean      | If task is completed |  
| deleted_at   | DateTime     | Soft delete timestamp |  

### **API Endpoints (REST):**  
#### **Tasks**  
- `POST /tasks` → Create new task  
- `GET /tasks` → List tasks (with filters)  
- `PUT /tasks/{id}` → Update task  
- `DELETE /tasks/{id}` → Soft delete task  

#### **Auth**  
- `POST /auth/login` (OAuth, Magic Link)  
- `POST /auth/logout`  

---

## **6. Error Handling & Validation**  

✔ **Task input validation:**  
   - Title **required**  
   - Categories **limited to max X per task**  
✔ **Graceful error handling** for invalid NLP parsing (fallback to manual input)  
✔ **API error responses:**  
   - **400:** Invalid input  
   - **401:** Unauthorized  
   - **404:** Not found  
✔ **Retries for failed background jobs** (Sidekiq)  

---

## **7. Testing Plan**  

### **Unit Tests:**  
✔ Task creation & parsing  
✔ Recurring task logic  
✔ API request validation  

### **Integration Tests:**  
✔ Full task lifecycle (Create → Edit → Complete → Delete)  
✔ Notification delivery via FCM  
✔ User authentication flow  

### **UI/UX Testing:**  
✔ Task entry field **handles NLP properly**  
✔ Recurring task interactions work as expected  
✔ Task filtering & sorting works correctly  

---

## **Next Steps**  
1. **Decide on hosting & CI/CD pipeline**  
2. **Set up the Rails backend & API endpoints**  
3. **Develop the React/React Native frontend**  
4. **Implement NLP parsing for task input**  

---

### **Final Notes:**  
This spec provides a **detailed, developer-ready plan** that covers **features, architecture, data models, API structure, error handling, and testing**. Let me know if you'd like any refinements before development begins!