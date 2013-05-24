class HomeController < ApplicationController

  # GET /
  def index
    return unless session[:path].present? && params[:anagram].present?
    @finder = AnagramFinder.new session[:path], params[:anagram]
  end

  # POST /upload
  def upload
    uploaded_file = params[:uploaded_file]

    unless uploaded_file.present?
      flash[:error] = "Please choose a file to upload"
      render :index and return
    end

    filename = uploaded_file.original_filename
    contents = uploaded_file.read

    unless File.extname(filename) == ".txt"
      flash[:error] = "Only .txt files are allowed"
      render :index and return
    end

    time = Benchmark.realtime do
      file = Tempfile.new(filename) # create the temp file
      begin
        file.write(contents)
        session[:path] = file.path
      rescue IOError => e
        flash[:error] = "Directory not writable"
      ensure
        file.close # Close the file to ensure it saves properly!!!
      end
    end

    @upload = "#{filename} loaded in #{(time*1000).round}ms"

    render :index
  end
end