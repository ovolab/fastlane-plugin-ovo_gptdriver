require 'fastlane/action'

module Fastlane
  module Actions
    class OvoGptdriverUploadBuildAction < Action
      def self.run(params)
        Helper::OvoGptdriverHelper.upload_build(
          build_path: params[:build_path],
          organisation_key: params[:organisation_key],
          platform: params[:platform],
          metadata: params[:metadata]
        )
      end

      def self.description
        "An action to upload build files to the GPT Driver service."
      end

      def self.authors
        ["Christian Borsato"]
      end

      def self.return_value
        "This action returns a string representing the ID of the uploaded build, as returned by the GPT Driver service. If the upload fails due to any error (e.g., network issues, invalid input, or authentication failure), it returns nil."
      end

      def self.details
        "This action uploads a build artifact to the GPT Driver service, along with relevant metadata such as platform, organization key, and custom deployment information (e.g., branch name). It is intended for use in CI/CD environments and ensures that each build is properly registered with GPT Driver. If the upload fails, the action returns nil instead of raising an error, allowing for graceful handling."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :build_path,
            env_name: "GPTDRIVER_BUILD_PATH",
            description: "The build binary file path to upload to GPT Driver (e.g., /path/to/your/build_file.apk)",
            optional: false,
            is_string: true
          ),
          FastlaneCore::ConfigItem.new(
            key: :organisation_key,
            env_name: "GPTDRIVER_ORGANISATION_KEY",
            description: "The unique organization key used to identify your GPT Driver account",
            optional: false,
            is_string: true
          ),
          FastlaneCore::ConfigItem.new(
            key: :platform,
            env_name: "GPTDRIVER_PLATFORM",
            description: "The platform of the build being uploaded (e.g., android, ios)",
            optional: false,
            is_string: true
          ),
          FastlaneCore::ConfigItem.new(
            key: :metadata,
            env_name: "GPTDRIVER_METADATA",
            description: "A JSON string containing additional metadata for the upload (e.g., branch name, build type)",
            optional: true,
            is_string: true
          )
        ]
      end

      def self.is_supported?(platform)
        true
      end

      def self.category
        :misc
      end
    end
  end
end
