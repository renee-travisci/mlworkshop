require './shared'

# brought in from shared
project = @project
predict = @predict

# Create 3 projects:
# 'week', 'month', 'sixMonths'
['week', 'month', 'sixMonths'].each do |project_name|
  file_name = "#{project_name}.csv"
  insert = Google::Apis::PredictionV1_6::Insert.new(id: project_name)
  insert.storage_data_location = "#{project}.appspot.com/#{file_name}"
  puts predict.insert_trained_model(project, insert).inspect
  puts predict.get_trained_model(project, project_name).inspect
end
