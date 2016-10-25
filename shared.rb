require 'google/apis/prediction_v1_6'
require 'googleauth'
require 'pry'

GOOGLE_APPLICATION_CREDENTIALS = "#{File.expand_path(File.dirname(__FILE__))}/creds.json"


scopes =  ['https://www.googleapis.com/auth/cloud-platform',
           'https://www.googleapis.com/auth/compute']

 Prediction = Google::Apis::PredictionV1_6
 @predict = Prediction::PredictionService.new

File.open(GOOGLE_APPLICATION_CREDENTIALS, "r") do |json_io|
  @predict.authorization = Google::Auth::DefaultCredentials.make_creds(
      scope: scopes,
      json_key_io: json_io
  )
end

@project = "mlworkshoptest" # my sample project
