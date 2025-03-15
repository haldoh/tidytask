require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  let(:user) { create(:user) }
  let(:task) { create(:task, user: user) }

  before do
    Warden.test_mode!
    login_as(user, scope: :user)
  end

  after do
    Warden.test_reset!
  end

  describe 'GET /tasks' do
    it 'returns a successful response' do
      get tasks_path
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get tasks_path
      expect(response).to render_template(:index)
    end

    it 'assigns all tasks for the current user' do
      user_tasks = create_list(:task, 3, user: user)
      create_list(:task, 2, user: create(:user))

      get tasks_path
      expect(assigns(:tasks)).to match_array(user_tasks)
    end
  end

  describe 'GET /tasks/:id' do
    it 'returns a successful response' do
      get task_path(task)
      expect(response).to be_successful
    end

    it 'renders the show template' do
      get task_path(task)
      expect(response).to render_template(:show)
    end

    it 'assigns the requested task' do
      get task_path(task)
      expect(assigns(:task)).to eq(task)
    end
  end

  describe 'GET /tasks/new' do
    it 'returns a successful response' do
      get new_task_path
      expect(response).to be_successful
    end

    it 'renders the new template' do
      get new_task_path
      expect(response).to render_template(:new)
    end

    it 'assigns a new task' do
      get new_task_path
      expect(assigns(:task)).to be_a_new(Task)
    end
  end

  describe 'POST /tasks' do
    let(:valid_attributes) { { title: 'New Task', completed: false } }

    context 'with valid parameters' do
      it 'creates a new Task' do
        expect do
          post tasks_path, params: { task: valid_attributes }
        end.to change(Task, :count).by(1)
      end

      it 'redirects to the created task' do
        post tasks_path, params: { task: valid_attributes }
        expect(response).to redirect_to(task_path(Task.last))
      end

      it 'sets the correct user' do
        post tasks_path, params: { task: valid_attributes }
        expect(Task.last.user).to eq(user)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { { title: '' } }

      it 'does not create a new Task' do
        expect do
          post tasks_path, params: { task: invalid_attributes }
        end.not_to change(Task, :count)
      end

      it 'renders a response with 422 status' do
        post tasks_path, params: { task: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders the new template' do
        post tasks_path, params: { task: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH /tasks/:id' do
    let(:new_attributes) { { title: 'Updated Task', completed: true } }

    context 'with valid parameters' do
      it 'updates the requested task' do
        patch task_path(task), params: { task: new_attributes }
        task.reload
        expect(task.title).to eq('Updated Task')
        expect(task.completed).to be true
      end

      it 'redirects to the task' do
        patch task_path(task), params: { task: new_attributes }
        expect(response).to redirect_to(task_path(task))
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { { title: '' } }

      it 'renders a response with 422 status' do
        patch task_path(task), params: { task: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders the edit template' do
        patch task_path(task), params: { task: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE /tasks/:id' do
    let!(:task) { create(:task, user: user) }

    it 'soft deletes the task' do
      expect do
        delete task_path(task)
      end.not_to change(Task.unscoped, :count)

      expect(response).to redirect_to(tasks_path)
      expect(Task.find_by(id: task.id)).to be_nil
      expect(Task.unscoped.find(task.id).deleted_at).to be_present
    end

    it 'does not show soft-deleted tasks in index' do
      delete task_path(task)

      get tasks_path
      expect(response).to have_http_status(:success)
      expect(response.body).not_to include(task.title)
    end

    it 'returns 404 when trying to view a soft-deleted task' do
      delete task_path(task)

      get task_path(task)
      expect(response).to have_http_status(:not_found)
    end
  end
end
