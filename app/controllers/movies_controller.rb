class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
       @all_ratings = Movie.ratings

    #Initial setting up of sessions
    session[:ratings] ||= @all_ratings
    session[:sort] ||= 'id'
    
    if params[:sort] == 'title'
    @title_hilite = session[:title_hilite] = "hilite" 
    elsif params[:sort] == 'release_date'
    @release_date_hilite = session[:release_date_hilite] = "hilite" 
    end
    
    #Used to remember what was selected
    session[:ratings] = params[:ratings].keys if params[:ratings]
    session[:sort] = params[:sort] if params[:sort]

    #For RESTfulness
    redirect_to movies_path(ratings: Hash[session[:ratings].map {|r| [r,1]}], sort: session[:sort]) if  params[:ratings].nil? || params[:sort].nil?

    @ratings = session[:ratings]
    @sort_by = session[:sort]

    @movies = Movie.where(rating: @ratings).order(@sort_by)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
