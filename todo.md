# TidyTask - A Personal Task Management App — To-Do Checklist

A comprehensive, step-by-step guide to building the application with a focus on TDD, incremental development, and thorough testing.

---

## Chunk A: Project Setup

- [x] **Initialize Rails Project**
  - [x] `rails new personal-task-manager -T --database=postgresql`
  - [x] Validate that the project structure is correct
- [x] **Add RSpec**
  - [x] Include `rspec-rails` in Gemfile
  - [x] `bundle install`
  - [x] `rails generate rspec:install`
  - [x] Confirm `.rspec` and `spec_helper.rb` are created
- [x] **Integrate Devise**
  - [x] Add `devise` to Gemfile
  - [x] `rails generate devise:install`
  - [x] Confirm Devise initializer exists
- [x] **Commit to Version Control**
  - [x] Ensure initial commit includes Gemfile, .rspec, etc.

---

## Chunk B: Basic Models & Migrations

- [x] **Generate User Model (Devise)**
  - [x] `rails generate devise User`
  - [x] Migrate database
  - [x] Validate `User` model is created
- [x] **Generate Task Model**
  - [x] `rails generate model Task title:string completed:boolean user:references`
  - [x] Set defaults (completed: false) in migration
  - [x] Migrate database
- [x] **Add Associations & Validations**
  - [x] `User has_many :tasks`
  - [x] Task validations (`title` presence, `completed` default, belongs to user)
- [x] **Model Specs**
  - [x] Write specs for `Task` validations & associations
  - [x] Write specs for `User` associations
  - [x] Run tests (they should pass)

---

## Chunk C: Task CRUD & Testing

- [x] **Write Request Specs (Tasks)**
  - [x] `GET /tasks` (index)
  - [x] `POST /tasks` (create)
  - [x] `GET /tasks/:id` (show)
  - [x] `PUT/PATCH /tasks/:id` (update)
  - [x] `DELETE /tasks/:id` (simple destroy, for now)
  - [x] Confirm these specs fail before implementation
- [x] **Implement TasksController**
  - [x] Implement each action minimally to pass specs
  - [x] Ensure strong parameters for tasks
  - [x] Update `routes.rb` (resources :tasks)
  - [x] Run tests (they should now pass)

---

## Chunk D: Soft Delete & Testing

- [ ] **Add Soft Delete Column**
  - [ ] `rails generate migration AddDeletedAtToTasks deleted_at:datetime`
  - [ ] Migrate database
- [ ] **Implement Soft Delete in Model**
  - [ ] Update `Task` to default-scope tasks where `deleted_at` is `nil`
  - [ ] Possibly add a `scope :active, -> { where(deleted_at: nil) }`
- [ ] **Update Controller Delete Logic**
  - [ ] `tasks_controller.rb`: set `deleted_at` instead of real destroy
  - [ ] Confirm tasks with `deleted_at` do not appear in `index/show`
- [ ] **Test Soft Delete**
  - [ ] Request specs verifying tasks still exist in DB
  - [ ] Confirm tasks are hidden from standard fetches
  - [ ] Tests pass

---

## Chunk E: Recurring Tasks (Basic)

- [ ] **Add Recurring Columns**
  - [ ] `recurring:boolean, default: false`
  - [ ] `recurrence_pattern:string (nullable)`
- [ ] **Model-Level Validation**
  - [ ] If `recurring` is true, `recurrence_pattern` cannot be blank
- [ ] **Generate Next Occurrence Logic**
  - [ ] `#generate_next_occurrence(date)` (model or service method)
  - [ ] Basic patterns: daily, weekly
  - [ ] Returns new Task instance with updated date
- [ ] **Test Recurring Logic**
  - [ ] Unit tests for valid recurrence patterns
  - [ ] Edge cases for missing pattern
  - [ ] Confirm tests pass

---

## Chunk F: NLP Parsing Service (Basic)

- [ ] **Create `task_parser.rb` Service**
  - [ ] Accepts a string (e.g., “Pay rent every month on the 1st”)
  - [ ] Attempts to parse title, due date, priority, recurrence
  - [ ] Default priority if not provided
- [ ] **Write Parser Specs**
  - [ ] Multiple test strings for different scenarios
  - [ ] Confirm correct extraction
- [ ] **Integrate Parser into Controller**
  - [ ] If `params[:text_input]` is present, use parser
  - [ ] Fallback to manual fields otherwise
- [ ] **Confirm Parser & Tests Pass**
  - [ ] Validate integration with Task creation

---

## Chunk G: Notifications & Background Jobs

- [ ] **Add Sidekiq & Redis**
  - [ ] Add gems
  - [ ] Configure `sidekiq.rb`, set up Redis locally
- [ ] **ReminderJob**
  - [ ] Queries tasks nearing `due_date`
  - [ ] Sends push notifications (mocked for test)
- [ ] **User FCM Tokens**
  - [ ] Extend `User` model (FCM token field)
  - [ ] Possibly add separate model/table if multiple tokens per user
- [ ] **Test ReminderJob**
  - [ ] Ensure job is enqueued
  - [ ] Mocks FCM calls
  - [ ] Tasks near their due_date are selected

---

## Chunk H: Integrate Web Frontend (React)

- [ ] **Initialize React App**
  - [ ] Using Create React App or Vite
  - [ ] Confirm basic app runs
- [ ] **Setup State Management**
  - [ ] Add Redux or other library
  - [ ] Create store, reducers, actions
- [ ] **Login Flow**
  - [ ] Use Devise endpoints (session creation, etc.)
  - [ ] Store user token/cookie
  - [ ] Basic form for email/password
- [ ] **TasksList Component**
  - [ ] Fetch tasks from API
  - [ ] Display tasks in a list
  - [ ] Form to create tasks (text-based or normal fields)
- [ ] **Integration Tests**
  - [ ] Use React Testing Library (or Cypress)
  - [ ] Confirm tasks are rendered
  - [ ] Confirm creation works & new task appears

---

## Chunk I: Integrate Mobile Frontend (React Native)

- [ ] **Initialize React Native Project**
  - [ ] Expo or bare RN (choose one)
  - [ ] Confirm app runs in simulator/emulator
- [ ] **Authentication**
  - [ ] Same Devise endpoints
  - [ ] Store tokens securely (AsyncStorage or similar)
- [ ] **TaskList Screen**
  - [ ] Display tasks from API
  - [ ] Create tasks with form or single text-input
  - [ ] Mark tasks complete (PATCH)
- [ ] **Push Notifications Setup**
  - [ ] FCM integration (placeholder or partial)
  - [ ] Confirm device token can be stored
- [ ] **Basic Jest Tests**
  - [ ] Ensure components render
  - [ ] API calls on mount
  - [ ] Minimal coverage

---

## Chunk J: Final Integration, Polish, & Deployment

- [ ] **Code Review & Cleanup**
  - [ ] Resolve TODOs in Rails, React, RN
  - [ ] Remove unused code, console.logs, etc.
- [ ] **Enhance NLP Parser**
  - [ ] Handle advanced patterns (e.g., “every 3rd Wednesday”)
  - [ ] More thorough date/time extraction
- [ ] **UI/UX Refinements**
  - [ ] Loading states, error displays
  - [ ] Polished design (themes, icons, etc.)
- [ ] **CI/CD Pipeline**
  - [ ] Configure GitHub Actions or GitLab CI
  - [ ] Automatic test runs on push
  - [ ] Lint checks for Ruby & JavaScript
- [ ] **Deployment**
  - [ ] Prepare config for Heroku, AWS, or chosen platform
  - [ ] Set environment variables, secrets
  - [ ] Deploy & verify
- [ ] **Final Testing & Acceptance**
  - [ ] Full test suite passes
  - [ ] End-to-end user flow verified
  - [ ] Green light for production

---

## How to Use This Checklist

- Tackle one **chunk** at a time.
- Check off each item as you complete it.
- For TDD, **write tests before** implementing each feature.
- Commit frequently so you have a clear history of each step.

Good luck with building your **Personal Task Management App**!
