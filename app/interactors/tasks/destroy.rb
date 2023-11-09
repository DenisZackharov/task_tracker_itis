module Tasks
  class Destroy
    include Interactor

    delegate :task, to: :context
    delegate :project, to: :task

    def call
      task.destroy
    end

    after do
      TaskMailer.task_destroyed(project, task.name, task.project.name).deliver_later
    end
  end
end
