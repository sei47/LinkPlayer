class ParticipantsController < ApplicationController
  def create
    participant = Participant.new(participant_params)
    if participant.save
      redirect_to community_path(@community), notice: "参加しました"
    else
      flash.now[:danger] = "失敗しました"
      redirect_to communities_path
    end
  end

  def destroy
    participant = Participant.find_by(user_id: participant_params[:user_id])
    if participant.destroy
      redirect_to community_path(@community), notice: "脱退しました"
    else
      flash.now[:danger] = "失敗しました"
      redirect_to communities_path
    end
  end

  private

  def participant_params
    params.permit(:community_id, :user_id)
  end
end
