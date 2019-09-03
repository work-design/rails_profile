class Profile::Admin::TutelagesController < Profile::Admin::BaseController
  before_action :set_tutelage, only: [
    :show, :edit, :update,
    :edit_crowd, :update_crowd, :destroy_crowd, :destroy_card,
    :destroy
  ]

  def index
    q_params = {}
    #q_params.merge! default_params
    #q_params.merge! member_id: current_member.id if current_member
    q_params.merge! params.permit('pupil.real_name')
    @tutelages = Tutelage.distinct.joins(:cards).where.not(cards: { id: nil }).default_where(q_params).order(id: :desc).page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
    @pupil.assign_attributes(pupil_params)

    respond_to do |format|
      if @pupil.save
        format.html.phone
        format.html { redirect_to admin_tutelages_url }
        format.js { redirect_back fallback_location: admin_tutelages_url }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_back fallback_location: admin_tutelages_url }
        format.json { render :show }
      end
    end
  end

  def edit_crowd
    q_params = {
      'id-not': @tutelage.crowd_ids
    }
    q_params.merge! default_params
    @crowds = Crowd.default_where(q_params)
  end

  def update_crowd
    @tutelage.join_crowd params[:crowd_id]

    redirect_back fallback_location: admin_tutelages_url
  end

  def destroy_crowd
    cs = @tutelage.crowd_students.find_by(crowd_id: params[:crowd_id])
    cs.destroy if cs
    redirect_back fallback_location: admin_tutelages_url
  end

  def destroy_card
    card = @tutelage.cards.find(params[:card_id])
    card.tutelage = nil
    card.client = nil
    card.save
    
    redirect_back fallback_location: admin_tutelages_url
  end

  def destroy
    @pupil.destroy
    redirect_to admin_tutelages_url
  end

  private
  def set_tutelage
    @tutelage = Tutelage.find(params[:id])
  end

  def pupil_params
    params.fetch(:pupil, {}).permit(
      :real_name,
      :gender,
      :note
    )
  end

end
