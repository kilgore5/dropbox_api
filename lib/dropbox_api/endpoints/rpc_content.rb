module DropboxApi::Endpoints
  class RpcContent < DropboxApi::Endpoints::Rpc
    def initialize(builder)
      @connection = builder.build("https://content.dropboxapi.com") do |c|
        c.response :decode_result
      end
    end
  end
end
