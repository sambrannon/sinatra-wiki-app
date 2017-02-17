require 'sinatra'
require 'uri'

def page_content(title)
  File.read("pages/#{title}.txt")
rescue Errno::ENOENT
  return nil
end

def save_content(title, content)
  File.open("pages/#{title}.txt", "w") do |file|
    file.print(content)
  end
end

get "/" do
  erb :welcome
end

get "/new" do
  erb :new
end

get "/:title" do
  @title = params[:title]
  @content = page_content(@title)
  erb :show
end

post "/create" do
  save_content(params['title'], params['content'])
  redirect URI.escape("/#{params['title']}")
end
