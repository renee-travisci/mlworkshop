require './shared'

# brought in from shared
project = @project
predict = @predict


puts "Would you like to:"
puts "1. Use the trained language predictor?"
puts "2. Created a new training model?"
puts "3. Train a model?"
puts "4. Predict with a model?"
puts "5. Get the status of a model?"

choice = gets.chomp

case choice.to_i
when 1

  project_id = "414649711441" # sample language project id
  hosted_model_name = "sample.languageid"

  input = Google::Apis::PredictionV1_6::Input.new()

  puts
  puts "please input a csv of words/phrases to test:"
  puts
  csv = gets.chomp
  puts

  csv.split(', ').each do |value|
    input.input = {csv_instance: [value]}
    result =  predict.predict_hosted_model(project_id, hosted_model_name, input)
    puts "#{value} is Probably: #{result.output_label}, based on:"
    result.output_multi.each do |res|
      puts "#{res.label}: #{res.score}"
    end
    puts "**********"
  end

when 2

  #Create!
  puts "What project name would you like?"
  project_name = gets.chomp
  puts "what is the training file name? (default is test_data.csv)"
  file_name = gets.chomp
  file_name = 'test_data.csv' if file_name.empty?
  insert = Google::Apis::PredictionV1_6::Insert.new(id: project_name)
  insert.storage_data_location = "#{project}.appspot.com/#{file_name}"
  puts predict.insert_trained_model(project, insert).inspect

when 3

  #Update!
  puts "What project name are you updating?"
  project_name = gets.chomp
  puts "please input the 'day of week, hour of day':"
  csv = gets.chomp
  puts "please input the expected load (number of jobs):"
  jobs = gets.chomp
  update = Google::Apis::PredictionV1_6::Update.new(csv_instance: [csv], output: [jobs])

  puts predict.update_trained_model(project, project_name, update).inspect

when 4

  #Predict!
  input = Google::Apis::PredictionV1_6::Input.new()

  puts "What project name are you predicting with?"
  project_name = gets.chomp
  puts
  puts "please input a 'day of week, hour of day' to test:"
  puts
  value = gets.chomp
  puts

  input.input = {csv_instance: value.split(',')}
  result =  predict.predict_trained_model(project, project_name, input)
  puts "#{value} is Probably: #{result.output_value}"

when 5

  # Check!
  puts "What project name are you checking?"
  project_name = gets.chomp
  puts predict.get_trained_model(project, project_name).inspect
end
