class ControllerConstants
  module Trips
    MAP_OPTIONS = {
      defaults: {
        map_options: {
          "type" => "ROADMAP",
          "center_latitude" => 180,
          "center_longitude" => 180,
          "zoom" => 17,
          "auto_adjust" => true,
          "labels" => true,
          "detect_location" => true,
          "mapTypeControl" => false,
          "center_on_user" => true
        }
      }
    }.freeze
  end
end