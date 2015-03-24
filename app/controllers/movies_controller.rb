# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController

  def index
    if not session.blank?
      session.each do |k,v|
        if params[k] == nil
          params[k] = v
        end
      end
    end
    @all_ratings = Movie.all_ratings
    @sort_key = params[:sort_by]
    @filter_ratings = params[:ratings]
    if @filter_ratings.blank? == false
      @filter_ratings = @filter_ratings.keys
    else
      @filter_ratings = @all_ratings
    end
    @movies = Movie.order(@sort_key).find_all_by_rating(@filter_ratings)
    if not params.blank?
      params.each  do |k,v|
        session[k] = v
      end
    end
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # Look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
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
