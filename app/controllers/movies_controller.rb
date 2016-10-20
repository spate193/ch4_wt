# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController
 def index
    @sort = params[:sort]
    @movies = Movie.order(@sort)
    @all_ratings = params[:sort].collect {|key,value| key }
    #['G', 'PG', 'PG-13', 'R']
    
 end
  
  def create
    #@movie = Movie.create!(params[:movie]) #old way
    @movie = Movie.create!(movie_params)  # new way
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end
  
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.html.haml by default
  end
  
  def new
    @movie = Movie.new
    # default: render 'new' template
  end 
  
  def edit
    @movie = Movie.find params[:id]
  end
  
  def update
    @movie = Movie.find params[:id]
    #@movie.update_attributes!(params[:movie])  # old way
    @movie.update_attributes!(movie_params)  # new way  
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end
  
  def destroy
   @movie = Movie.find(params[:id])
   @movie.destroy
   flash[:notice] = "Movie '#{@movie.title}' deleted."
   redirect_to movies_path
  end
  
  def find_class(header)
    params[:sort] == header ? 'hilite' : nil
  end
  helper_method :find_class
  
  private 
  
  def movie_params 
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
  
end


  