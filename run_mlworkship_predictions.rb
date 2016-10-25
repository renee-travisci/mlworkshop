require './shared'
require 'csv'

# brought in from shared
project = @project
predict = @predict

input = Google::Apis::PredictionV1_6::Input.new()
#'week', 'month', 'sixMonths'
['week', 'month', 'sixMonths'].each do |project_name|
  results = []
  (0..6).each do |d|
    (0..23).each do |h|
      input.input = {csv_instance: [d,h]}
      results << [predict.predict_trained_model(project, project_name, input).output_value, d, h]
    end
  end
  CSV.open("#{project_name}.csv", "wb") do |csv|
    csv << ['count', 'day', 'hour']
    results.each do |result|
      csv << result
    end
  end
end
