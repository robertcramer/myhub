module Myhub
  class Github
    include HTTParty
    base_uri "https://api.github.com"

    # Your code here too!
    def initialize
      @headers = {
        "Authorization"  => "token #{ENV["AUTH_TOKEN"]}",
        "User-Agent"     => "HTTParty"
      }
    end

    def get_issues
      response = Github.get("/orgs/TIY-ATL-ROR-2015-Sep/issues",
                    :headers => @headers,
                    :query => {state: "all"})
      response.map { |x| {number: x["number"], title: x["title"], url: x["html_url"], state: x["state"]} }
    end

    def open_issue(number)
      Github.patch("/repos/TIY-ATL-ROR-2015-Sep/assignments/issues/:number",
                   :headers => @headers,
                   :body => {state: "open"}.to_json )
    end

    def close_issue(number)
      Github.patch("/repos/TIY-ATL-ROR-2015-Sep/assignments/issues/:number",
                   :headers => @headers,
                   :body => {state: "closed"}.to_json )
    end


  end
end
