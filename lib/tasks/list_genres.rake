namespace :utils do
  namespace :genres do

    desc "List all genres"
    task :list => :environment do
      videos = Video.where(user_id: 5842)
      all_genres = videos.map {|video| video.video_custom_attributes.where(attribute_name: "genres_en").first.attribute_value if video.video_custom_attributes.where(attribute_name: "genres_en").first}
      
      dirty_genres = all_genres.uniq.join(",").split(",")
      clean_genres = dirty_genres.map { |genre| genre.strip.downcase }

      puts clean_genres.uniq
    end

  end
end
