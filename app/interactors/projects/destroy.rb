module Projects
  class Destroy
    include Interactor
        
    delegate :project, to: :context

    def call
      context.fail!(error: "Fail..") unless project.destroy
      context.notice = "project successfully deleted"
    end
  end
end
