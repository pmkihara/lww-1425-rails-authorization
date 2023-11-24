class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # scope = Restaurant
      if user.admin
        # admin pode ver todos os restaurantes
        # scope.all = Restaurant.all
        scope.all
      else
        # demais usuários podem ver apenas os restaurantes que eles criaram
        # Restaurant.where(user: current_user)
        scope.where(user: user)
      end
    end
  end

  def show?
    true # todos podem ver
  end

  def create?
    # true # todos podem criar
    user.admin
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end

  private

  def owner?
    # @restaurant.user == current_user
    # current_user = user
    # @restaurant = record
    record.user == user # apenas o dono do restaurante tem permissão
  end
end
