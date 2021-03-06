module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))
    when /the video listing page/
      '/videos/list'
    when /the contact page/
      '/contact'
    when /the resume page/
      '/resume'
    when /the ('|")(.+)('|") post page/
      "/#{$2}"
    when /the new comment entry page for slug "([^"]*)"/
      "/#{$1}/comment/new"
    when /.*bad-url.*/
       '/post/show/0'
    when /('|")\/([0-9]{4})\/([0-9]{2})\/([0-9]{2})\/.+('|")/
      "#{$2}/#{$3}/#{$4}/#{$5}"
    when /('|")(\/[^\/]+)(\/[^\/]+)('|")/
      "#{$2}#{$3}"
    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
