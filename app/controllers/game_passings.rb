class GamePassings < Application
  include GamePassingsHelper

  before :ensure_authenticated, :exclude => [:index, :show_results]
  before :find_game
  before :ensure_game_is_started
  before :ensure_team_member, :exclude => [:index, :show_results]
  before :ensure_not_author_of_the_game, :exclude => [:index, :show_results]
  before :find_team, :exclude => [:show_results, :index]
  before :find_or_create_game_passing, :exclude => [:show_results, :index]
  before :ensure_author, :only => [:index]

  provides :json

  def show_current_level
    render
  end

  def index
    @game_passings = GamePassing.of_game(@game)
    render
  end

  def get_current_level_tip
    next_hint = @game_passing.upcoming_hints.first; # next_hint  ?

    { :hint_num => @game_passing.hints_to_show.length,
      :hint_text => @game_passing.hints_to_show.last.text,
      :next_available_in => next_hint.nil? ? nil : next_hint.available_in(@game_passing.current_level_entered_at) }.to_json
  end

  def post_answer
    @answer = params[:answer].strip
    save_log
    @answer_was_correct = @game_passing.check_answer!(@answer)
    unless @game_passing.finished?
      render :show_current_level
    else
      render :show_results
    end
  end

  def save_log
    if @game_passing.current_level.id
      @level = Level.find(@game_passing.current_level.id)
      Log.new do |l|
        l.game_id = @game.id
        l.level = @level.name
        l.team = @team.name
        l.time = Time.now
        l.answer = @answer
        l.save
      end
    end
  end

  def show_results
    render
  end

protected

  def find_game
    @game = Game.find params[:game_id]
  end

  # TODO: must be a critical section, double creation is possible!
  def find_or_create_game_passing
    @game_passing = GamePassing.first :conditions => { :team_id => @team.id, :game_id => @game.id }

    if @game_passing.nil?
      @game_passing = GamePassing.create! :team => @team, 
        :game => @game,
        :current_level => @game.levels.first
    end
  end

  def find_team
    @team = current_user.team
  end

  def ensure_game_is_started
    raise Unauthorized, "Нельзя играть в игру до её начала. И вообще, где вы достали эту ссылку? :-)" unless @game.started?
  end

  def ensure_not_author_of_the_game
    raise Unauthorized, "Нельзя играть в собственные игры, сорри :-)" if @game.created_by?(current_user)
  end
end
