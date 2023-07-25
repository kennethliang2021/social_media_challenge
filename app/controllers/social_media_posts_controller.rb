class SocialMediaPostsController < ApplicationController
  before_action :set_social_media_post, only: %i[ show edit update destroy ]

  # GET /social_media_posts or /social_media_posts.json
  def index
    @social_media_posts = SocialMediaPost.between_dates(params[:start_date], params[:end_date])
                                         .by_social_media_type(params[:social_media_type])
                                         .by_custom_list(params[:custom_list_id])
                                         .by_identifiable_type(params[:identifiable_type])
  end

  # GET /social_media_posts/1 or /social_media_posts/1.json
  def show
  end

  # GET /social_media_posts/new
  def new
    @social_media_post = SocialMediaPost.new
  end

  # GET /social_media_posts/1/edit
  def edit
  end

  # POST /social_media_posts or /social_media_posts.json
  def create
    @social_media_post = SocialMediaPost.new(social_media_post_params)

    respond_to do |format|
      if @social_media_post.save
        format.html { redirect_to social_media_post_url(@social_media_post), notice: "Social media post was successfully created." }
        format.json { render :show, status: :created, location: @social_media_post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @social_media_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /social_media_posts/1 or /social_media_posts/1.json
  def update
    respond_to do |format|
      if @social_media_post.update(social_media_post_params)
        format.html { redirect_to social_media_post_url(@social_media_post), notice: "Social media post was successfully updated." }
        format.json { render :show, status: :ok, location: @social_media_post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @social_media_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /social_media_posts/1 or /social_media_posts/1.json
  def destroy
    @social_media_post.destroy

    respond_to do |format|
      format.html { redirect_to social_media_posts_url, notice: "Social media post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_social_media_post
      @social_media_post = SocialMediaPost.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def social_media_post_params
      params.require(:social_media_post).permit(:postable_id, :postable_type, :posted_at)
    end
end
