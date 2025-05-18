require 'fastlane_core/ui/ui'
require 'json'
require 'rest-client'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?(:UI)

  module Helper
    class OvoGptdriverHelper
      API_BASE_URL = "https://api.mobileboost.io"

      # GPT Driver API Documentation: https://docs.mobileboost.io/gpt-driver-api/basics/images-and-media/api
      def self.upload_build(build_path:, organisation_key:, platform:, metadata:)
        UI.message("Starting upload of build '#{build_path}' to GTP Driver...")

        begin
          # Start request using RestClient
          response = RestClient.post(
            "#{API_BASE_URL}/uploadBuild/",
            {
              build: File.new(build_path, 'rb'),        # APK/ZIP/TAR.GZ file
              organisation_key: organisation_key,       # Organization key
              platform: platform,                       # Platform type
              metadata: metadata                        # Metadata as JSON
            },
            { content_type: :multipart }                # Specify multipart/form-data
          )

          json_response = JSON.parse(response.body)
          build_id = json_response["buildId"]

          # If the request is successful (HTTP 2xx)
          UI.success("Build '#{build_path}' uploaded successfully to GPT Driver.\nBuild ID assigned: #{build_id}")

          # Return the build id
          return build_id
        rescue RestClient::ExceptionWithResponse => e
          # Server returned an HTTP error (e.g. 400, 401, 500)
          UI.error(
            "An error occurred while uploading the build '#{build_path}' to GTPDriver.\nStatus Code: #{e.http_code}\nBody: #{e.response}"
          )
          return nil
        rescue StandardError => e
          # Catch any other unexpected error
          UI.error("An unexpected error occurred: #{e.to_s}")
          return nil
        end
      end
    end
  end
end
