module ApplicationHelper
  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
      next if message.blank?

      type = :success if type == :notice
      type = :error   if type == :alert
      next unless [:error, :info, :success, :warning].include?(type)

      Array(message).each do |msg|
        text = content_tag(:div,
          content_tag(:button, raw("&times;"), :class => "close", "data-dismiss" => "alert") +
          msg.html_safe, :class => "alert fade in alert-#{type}")
        flash_messages << text if message
      end
    end
    flash_messages.join("\n").html_safe
  end

  def header_nav
    items = []
    if user_signed_in?
      items = [
        {label: "Hello #{current_user.email}", path: "#", html: {class: 'disabled'}},
        {label: "Sign Out", path: logout_path, path_options: {method: 'delete'}}
      ]
    else
      items = [
        {label: "Sign Up", path: sign_up_path},
        {label: "Sign In", path: sign_in_path}
      ]
    end
    render partial: 'layouts/header_nav', locals: {items: items}
  end
end
