class GroupsController < ApplicationController




  def show

    group = Group.find_by(id: params[:id])
    render json: group.as_json
  end

end
