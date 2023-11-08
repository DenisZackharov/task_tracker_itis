class ProjectPolicy < ApplicationPolicy
  authorize :user, allow_nil: true

  def index?
    true
  end

  def new?
    user.present?
  end

  def create?
    user.present?
  end

  def destroy?
    project_membership_and_user_present? && owner?
  end

  def edit?
    project_membership_and_user_present?
  end

  def show?
    true
  end

  def update?
    project_membership_and_user_present?
  end

  private

  def project_membership
    @project_membership ||= ProjectMembership.find_by(project: record, user: user)
  end

  def project_membership_and_user_present?
    project_membership.present? && user.present?
  end

  def owner?
    project_membership.role == :owner
  end
end
