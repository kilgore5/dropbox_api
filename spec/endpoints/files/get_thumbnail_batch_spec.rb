describe DropboxApi::Client, "#get_thumbnail_batch" do
  let(:path_prefix) { DropboxScaffoldBuilder.prefix_for :get_thumbnail_batch }

  before :each do
    @client = DropboxApi::Client.new
  end

  it "returns files", :cassette => "get_thumbnail_batch/success" do
    result = @client.get_thumbnail_batch ["#{path_prefix}/img.png"]
    entry = result.entries.first

    expect(entry.metadata).to be_a(DropboxApi::Metadata::File)
    expect(entry.thumbnail).to be_a(String)
    expect(entry.metadata.name).to eq("img.png")
  end

  it "includes an error entry if the file can't be found", :cassette => "get_thumbnail_batch/not_found" do
    result = @client.get_thumbnail_batch ["#{path_prefix}/unknown_file.jpg"]
    expect(result.entries.first).to be_a(DropboxApi::Errors::NotFoundError)
  end

  it "raises an argument error with invalid options" do
    expect {
      @client.get_thumbnail_batch ["#{path_prefix}/img.png"], :invalid_arg => "value"
    }.to raise_error(ArgumentError)
  end
end
