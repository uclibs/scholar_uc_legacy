class Utf8Sanitizer

  SANITIZE_ENV_KEYS = %w(
    HTTP_REFERER
    PATH_INFO
    REQUEST_URI
    REQUEST_PATH
    QUERY_STRING
  )

  def initialize(app)
    @app = app
  end

  def call(env)
    SANITIZE_ENV_KEYS.each do |key|
      string = env[key].to_s
      valid = URI.decode(string).force_encoding('UTF-8').valid_encoding?
      # Don't accept requests with invalid byte sequence
       return [ 404, {'Content-Type' => 'text/html'}, [ "
               <h1>Page Not Found</h1> <p>
              The page you are looking for may have been removed, had its name changed, or is temporarily unavailable.</p>
              <h2>Please try the following:</h2>
              <ul>
              <li>If you typed the page address in the Address bar, make sure that it is spelled correctly. </li>
              <li>Go to the scholar.uc.edu, and then look for links to the information you want.</li>
              <li>Click the Back button on your browser to try another link. </li>
              <li>If you reached this page using a bookmark, the page you are looking for may have moved.</li>
              </ul></div>" ] ] unless valid
    end

    @app.call(env)
  end
end
