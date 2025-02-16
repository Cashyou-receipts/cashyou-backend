# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

task :parse_image => :environment do
  image_filepath = ENV["IMAGE_FILEPATH"]
  write_to = ENV["WRITE_TO"]

  unless image_filepath && write_to
    puts "\n\nMUST INCLUDE IMAGE_FILEPATH FOR LOCAL IMAGE AND WRITE_TO FOR WRITE LOCATION\n\n"
    puts "Proper usage: bundle exec rails parse_image IMAGE_FILEPATH={your local filepath} WRITE_TO={destination}\n\n"
    exit 1
  end

  puts "\n\nTHIS WILL MAKE API CALLS TO AWS AND GOOGLE IMAGE API. ARE YOU SURE?\n\nENTER Y/N\n\n"
  answer = STDIN.gets.chomp.strip.downcase
  exit 1 unless answer == "y"
  puts "\n\n"

  begin
    key = "test/test_image"
    aws = AwsS3Service.new
    aws.upload_receipt!(filename: image_filepath, object_key: key, from: "fakeperson@example.com")
    vision = VisionApiService.new(key)
    body = JSON.parse(vision.make_text_detection_http_call!)
    File.write(write_to, body)
    aws.delete_receipt(keys: key)
    puts "COMPLETED\n\n"
  rescue => exception
    puts "Something went wrong:\n\n#{exception.message}\n\n"
    puts "Backtrace:\n\n#{exception.backtrace}"
  end
end
