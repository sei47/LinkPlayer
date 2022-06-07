class ParticipantsController < ApplicationController
  def create
    participant = Participant.new(participant_params)
    if participant.save
      redirect_to community_path(@community), notice: "参加しました"
    else
      flash.now[:danger] = "保存に失敗しました"
      redirect_to communities_path
    end
  end

  private

  def participant_params
    params.require(:participant).permit(:community_id, :user_id)
  end
end
