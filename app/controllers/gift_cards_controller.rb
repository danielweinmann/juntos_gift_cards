class GiftCardsController < StateController
  
  before_action :set_gift_card, except: %i[index new]

  respond_to :html

  def index
    @gift_cards = policy_scope(GiftCard)
    respond_with @gift_cards
  end

  def show
    authorize @gift_card
    respond_with @gift_card
  end

  def new
    @gift_card = GiftCard.new user: current_user
    authorize @gift_card
    respond_with @gift_card
  end

  def edit
    authorize @gift_card
    respond_with @gift_card
  end

  def update
    authorize @gift_card
    @gift_card.update(gift_card_params)
    respond_with @gift_card
  end

  def destroy
    authorize @gift_card
    @gift_card.destroy
    respond_with @gift_card
  end

  private

  def gift_card_params
    params.require(:gift_card).permit(*policy(@gift_card || GiftCard.new).permitted_attributes)
  end

  def set_gift_card
    @gift_card = GiftCard.find(params[:id])
  end

end
