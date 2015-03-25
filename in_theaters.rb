require "json"

movie_data = JSON.parse(File.read("in_theaters.json"))

# List of movies in theaters now method
def current_movies(movie_data)
# Blank movies array for storing my desired data
  movies = []

# Variables for all the data I need to display
  movie_data["movies"].each do |movie_info|
  title = movie_info["title"]
  year = movie_info["year"]
  runtime = movie_info["runtime"]
  mpaa_rating = movie_info["mpaa_rating"]
  critic_score = movie_info["ratings"]["critics_score"]
  audience_score = movie_info["ratings"]["audience_score"]
  overall_rating = (critic_score + audience_score) / 2

# Cast memebers data collection
  cast_members = []

    movie_info["abridged_cast"].take(3).each do |actors|
      cast_members += [actors["name"]]
    end

# Adding all my desired data to the movies array
  movies << [overall_rating, title, mpaa_rating, year, runtime, cast_members]
  end

# Method for displaying all my data in the movies array
  movies.sort_by! { |movie| - movie[0]}
  movies.each do |display|
    actors = display[5].join(", ")
    puts "#{display[0]} (score) - #{display[1]} - (#{display[2]}) - (#{display[3]}) - #{display[4]}mins\n Starring: #{actors}"
  end
end

# Display final output
current_movies(movie_data)
